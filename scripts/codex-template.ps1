param(
    [Parameter(Position=0)]
    [ValidateSet('configure','list-stacks','list-presets','show-config','reset-stack')]
    [string]$Command = 'configure',

    [string]$ProjectName,
    [string]$ProjectType,
    [string]$Stacks,
    [string]$Preset,
    [string]$Compatibility,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $PSScriptRoot
$CodexDir = Join-Path $Root '.codex'
$ConfigDir = Join-Path $CodexDir 'config'
$TemplatesDir = Join-Path $CodexDir 'templates\stacks'
$StackOutDir = Join-Path $CodexDir 'stack'
$StacksConfigPath = Join-Path $ConfigDir 'stacks.json'
$ProjectConfigPath = Join-Path $ConfigDir 'project.json'
$PresetsConfigPath = Join-Path $ConfigDir 'presets.json'

function Read-JsonFile([string]$Path) {
    if (-not (Test-Path $Path)) { throw "필수 파일이 없습니다: $Path" }
    return Get-Content $Path -Raw -Encoding UTF8 | ConvertFrom-Json
}

function Write-Utf8File([string]$Path, [string]$Content) {
    $parent = Split-Path -Parent $Path
    if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, [System.Text.UTF8Encoding]::new($false))
}

function Parse-List([string]$Value) {
    if ([string]::IsNullOrWhiteSpace($Value)) { return @() }
    return @($Value -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
}

function Get-AvailableStacks {
    $cfg = Read-JsonFile $StacksConfigPath
    return $cfg.stacks.PSObject.Properties
}

function Show-Stacks {
    Write-Host "사용 가능한 기술스택:" -ForegroundColor Cyan
    foreach ($p in Get-AvailableStacks) {
        $displayName = if ($p.Value.displayName) { $p.Value.displayName } else { $p.Name }
        Write-Host ("  {0,-18} [{1,-12}] {2}" -f $p.Name, $p.Value.category, $displayName)
    }
}

function Show-Presets {
    $cfg = Read-JsonFile $PresetsConfigPath
    Write-Host "사용 가능한 Preset:" -ForegroundColor Cyan
    foreach ($p in $cfg.presets.PSObject.Properties) {
        Write-Host ("  {0,-24} {1}" -f $p.Name, ($p.Value.stacks -join ', '))
    }
}

function Get-PresetStacks([string]$PresetName) {
    $cfg = Read-JsonFile $PresetsConfigPath
    $entry = $cfg.presets.$PresetName
    if ($null -eq $entry) {
        throw "알 수 없는 Preset '$PresetName' 입니다. '.\scripts\codex-template.ps1 list-presets'로 목록을 확인하세요."
    }
    return @($entry.stacks)
}

function Select-ProjectTypeInteractive {
    Write-Host ""
    Write-Host "프로젝트 유형을 선택하세요:" -ForegroundColor Cyan
    Write-Host "  1. new          신규 개발"
    Write-Host "  2. maintenance  기존 시스템 유지보수"
    Write-Host "  3. mixed        신규 개발 + 유지보수"
    Write-Host "  4. batch        Batch 중심"
    $choice = Read-Host "번호 또는 유형 입력"
    switch ($choice) {
        '1' { return 'new' }
        '2' { return 'maintenance' }
        '3' { return 'mixed' }
        '4' { return 'batch' }
        ''  { return 'mixed' }
        default { return $choice }
    }
}

function Select-StacksInteractive {
    Write-Host ""
    Show-Stacks
    Write-Host ""
    $inputStacks = Read-Host "기술스택을 쉼표로 구분해 입력하세요 (예: delphi2007,windows,postgresql)"
    return Parse-List $inputStacks
}

function Validate-Stacks([string[]]$Selected) {
    $available = @{}
    foreach ($p in Get-AvailableStacks) { $available[$p.Name] = $p.Value }
    foreach ($s in $Selected) {
        if (-not $available.ContainsKey($s)) {
            throw "알 수 없는 기술스택 '$s' 입니다. '.\scripts\codex-template.ps1 list-stacks'로 목록을 확인하세요."
        }
    }
}

function Generate-StackFiles([string[]]$Selected) {
    if (-not (Test-Path $StackOutDir)) { New-Item -ItemType Directory -Path $StackOutDir -Force | Out-Null }
    Get-ChildItem $StackOutDir -Filter '*.md' -File -ErrorAction SilentlyContinue | Remove-Item -Force

    $cfg = Read-JsonFile $StacksConfigPath
    foreach ($s in $Selected) {
        $entry = $cfg.stacks.$s
        $src = Join-Path $TemplatesDir $entry.template
        $dst = Join-Path $StackOutDir ("$s.md")
        if (-not (Test-Path $src)) { throw "'$s' 기술스택 Template을 찾을 수 없습니다: $src" }
        Copy-Item $src $dst -Force
    }
}

function Get-StackDisplayName([string]$Key) {
    $cfg = Read-JsonFile $StacksConfigPath
    $entry = $cfg.stacks.$Key
    if ($entry.displayName) { return $entry.displayName }
    return $Key
}

function Generate-ProjectMd([string]$Name, [string]$Type, [string[]]$Selected, [string[]]$Compat) {
    $stackLines = if ($Selected.Count -gt 0) {
        ($Selected | ForEach-Object { "- $(Get-StackDisplayName $_) ($_)" }) -join "`n"
    } else { '- 아직 설정되지 않음' }

    $compatLines = if ($Compat.Count -gt 0) {
        ($Compat | ForEach-Object { "- $_" }) -join "`n"
    } else { '- 현재 지원 중인 실행 환경을 유지한다.' }

    $content = @"
# 프로젝트 프로필

> scripts/codex-template.ps1 configure 명령으로 자동 생성된다.
> 프로젝트 고유의 추가 설명이 필요하면 .codex/context/ 문서를 사용한다.

## 프로젝트

- 이름: $Name
- 유형: $Type

## 기술스택

$stackLines

## 호환성 제약

$compatLines

## 프로젝트 우선순위

1. 안정성
2. 정확성
3. 유지보수성
4. 성능
5. 필요성이 입증된 경우에만 현대화

## 기술스택 규칙

선택된 기술스택의 상세 규칙은 .codex/stack/ 에 생성된다.
Codex는 해당 기술의 코드를 수정하기 전에 관련 Stack Rule을 먼저 확인한다.
"@
    Write-Utf8File (Join-Path $CodexDir 'project.md') $content
}

function Update-GeneratedSections([string[]]$Selected) {
    $stackRead = if ($Selected.Count -gt 0) {
        ($Selected | ForEach-Object { "- .codex/stack/$_.md" }) -join "`n"
    } else { '- 아직 설정되지 않음' }

    $path = Join-Path $CodexDir 'architecture.md'
    $base = Get-Content $path -Raw -Encoding UTF8
    $marker = '<!-- GENERATED-STACKS -->'
    $generated = "$marker`n## 활성 기술스택 규칙`n`n$stackRead`n"
    $index = $base.IndexOf($marker)
    if ($index -ge 0) {
        $base = $base.Substring(0, $index) + $generated
    } else {
        $base = $base.TrimEnd() + "`n`n" + $generated
    }
    Write-Utf8File $path $base
}

function Save-ProjectConfig([string]$Name, [string]$Type, [string[]]$Selected, [string[]]$Compat) {
    $obj = [ordered]@{
        projectName = $Name
        projectType = $Type
        stacks = @($Selected)
        compatibility = @($Compat)
        notes = @()
    }
    $json = $obj | ConvertTo-Json -Depth 5
    Write-Utf8File $ProjectConfigPath $json
}

switch ($Command) {
    'list-stacks' {
        Show-Stacks
        exit 0
    }

    'list-presets' {
        Show-Presets
        exit 0
    }

    'show-config' {
        Write-Host "현재 프로젝트 설정:" -ForegroundColor Cyan
        Get-Content $ProjectConfigPath -Raw -Encoding UTF8
        exit 0
    }

    'reset-stack' {
        if (Test-Path $StackOutDir) {
            Get-ChildItem $StackOutDir -Filter '*.md' -File -ErrorAction SilentlyContinue | Remove-Item -Force
        }
        Write-Host '생성된 기술스택 규칙을 제거했습니다.' -ForegroundColor Yellow
        exit 0
    }

    'configure' {
        Write-Host ""
        Write-Host "[Codex Project Template v2]" -ForegroundColor Cyan
        Write-Host "프로젝트 설정을 시작합니다."

        if ([string]::IsNullOrWhiteSpace($ProjectName)) {
            $ProjectName = Read-Host '프로젝트 이름'
        }
        if ([string]::IsNullOrWhiteSpace($ProjectName)) { $ProjectName = 'UnnamedProject' }

        if ([string]::IsNullOrWhiteSpace($ProjectType)) {
            $ProjectType = Select-ProjectTypeInteractive
        }
        if ([string]::IsNullOrWhiteSpace($ProjectType)) { $ProjectType = 'mixed' }

        if (-not [string]::IsNullOrWhiteSpace($Preset)) {
            $selectedStacks = Get-PresetStacks $Preset
            Write-Host "Preset 적용: $Preset" -ForegroundColor DarkCyan
        } else {
            $selectedStacks = Parse-List $Stacks
            if ($selectedStacks.Count -eq 0) {
                $selectedStacks = Select-StacksInteractive
            }
        }
        Validate-Stacks $selectedStacks

        $compatList = Parse-List $Compatibility
        if ($compatList.Count -eq 0) {
            $compatInput = Read-Host '호환성 제약을 쉼표로 구분해 입력하세요 (없으면 Enter)'
            $compatList = Parse-List $compatInput
        }

        Generate-StackFiles $selectedStacks
        Generate-ProjectMd $ProjectName $ProjectType $selectedStacks $compatList
        Update-GeneratedSections $selectedStacks
        Save-ProjectConfig $ProjectName $ProjectType $selectedStacks $compatList

        Write-Host ''
        Write-Host 'Codex 프로젝트 설정이 완료되었습니다.' -ForegroundColor Green
        Write-Host "프로젝트 : $ProjectName"
        Write-Host "유형     : $ProjectType"
        Write-Host "기술스택 : $($selectedStacks -join ', ')"
        if ($compatList.Count -gt 0) {
            Write-Host "호환성   : $($compatList -join ', ')"
        }
        Write-Host ''
        Write-Host '생성/갱신:' -ForegroundColor Cyan
        Write-Host '  .codex/project.md'
        Write-Host '  .codex/config/project.json'
        Write-Host '  .codex/architecture.md (자동 생성 영역)'
        Write-Host '  .codex/stack/*.md'
        Write-Host ''
        Write-Host '첫 사용 전 AGENTS.md와 .codex/project.md를 확인하세요.' -ForegroundColor Yellow
    }
}
