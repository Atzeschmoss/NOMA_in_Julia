# NOMA_in_Julia
Collection of different NOMA-related scripts. Written in Julia.

## Environment
The scripts where developed in VS-Code using the Julia extension. If you do not have Julia set up yet, you might want to check out the [Getting Started](https://www.julia-vscode.org/docs/dev/gettingstarted/) with Julia guide.

## Usage
In my setup, the scripts are executed by the __caller.jl__ file. This caller then executes the script in a module-like fashion. 
As a result, every execution is made on a "fresh" Julia workspace - without any previous variables beeing stored.
