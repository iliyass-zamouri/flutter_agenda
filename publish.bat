@echo off
setlocal
:PROMPT
SET /P CHANGELOG=did you add the new version update to CHANGELOG.md (y/[n])?
IF /I "%CHANGELOG%" NEQ "y" GOTO END

SET /P PUBSPEC=did you updated the new version in pubspec.yaml (y/[n])?
IF /I "%PUBSPEC%" NEQ "y" GOTO END

@echo on

powershell -Command " & git add ."
powershell -Command " & git commit -m %1"
powershell -Command " & git push origin main"
powershell -Command " & dart pub publish"

:END
endlocal

