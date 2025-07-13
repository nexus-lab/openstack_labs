@echo off

for /D %%D in (lab*) do (
    pushd %%D
    make
    popd
)
