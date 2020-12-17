### AUTHOR:  Maximilian S Puglielli (MSP)
### CREATED: 2020.12.16

$VasmRelativePath = "..\..\vasm\vasm6502_oldstyle\win\win10"

& "$VasmRelativePath\vasm6502_oldstyle.exe" "-Fbin" "-dotdir" $args[0] -o $args[1]

Move-Item -Path "$VasmRelativePath\$args[1]" -Destination "."
