@echo off
REM copies the contents of a directory selectively, ignoring source directories containing large files
REM copie le contenu d'un répertoire de manière sélective, en ne tenant pas compte des répertoires sources contenant des fichiers volumineux
setlocal enabledelayedexpansion

set rep=%~dp0
set /A nb=0
set /A i=0
set folder=C:\transfert\
if exist %folder% (
    echo folder %folder% already exists - removing it
    RMDIR /S %folder%
)
MKDIR %folder%

echo an empy folder %folder% has been created 
echo Analyse du dossier %rep%
for /f "delims=" %%a In ('dir /ad/b/s %rep%') Do (
    echo %%a | find "sources" > nul && goto :end
    set /A nb+=1
    REM on procède à la copie des fichiers
    set $p=%%a
    set $d=!$p:%rep%=%folder%!
    echo *****CREATING !$d!
    MKDIR !$d!
    copy %%a !$d!
    :end
    set /A i+=1
)
echo %i% dossiers au total
echo %nb% dossiers, hors sources
