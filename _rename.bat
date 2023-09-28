@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

for %%F in (*) do (
    set "oldname=%%F"
    set "extension="
    set "newname="

    for %%E in (!oldname!) do (
        set "extension=%%~xE"
        set "filename=%%~nF"

        rem Define character mapping for accentuated characters
        set "accents=áéíóúàèìòùäëïöüâêîôûãñçÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÂÊÎÔÛÃÑÇ"
        set "nonaccents=aeiouaeiouaeiouaeiouaeiouançAEIOUAEIOUAEIOUAEIOUAEIOUANÇ"

        rem Replace accentuated characters with non-accented counterparts
        set "newname=!filename!"
        for /l %%A in (0,1,63) do (
            set "char=!accents:~%%A,1!"
            set "replacement=!nonaccents:~%%A,1!"
            set "newname=!newname:%%char!=%%replacement%!"
        )

        rem Replace spaces with underscores
        set "newname=!newname: =_!"
        
        set "newname=!newname!!extension!"
    )

    if not "!oldname!"=="!newname!" (
        ren "!oldname!" "!newname!"
    )
)

endlocal