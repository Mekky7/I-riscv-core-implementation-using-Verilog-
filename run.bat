@echo off
set open_questa_gui=0
set terminate_questa_after_simulation=1

if %open_questa_gui%==0 (
    echo Running Questa in console mode...
    vsim -c -do run.do
) else (
    echo Running Questa with GUI...
    vsim -do run.do
)

if %terminate_questa_after_simulation%==1 (
    echo Questa is terminated!
    exit /b
) else (
    echo Simulation finished and staying in Questa!
    pause
)
