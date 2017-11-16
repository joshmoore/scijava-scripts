"== Path (Execution Environment) =="
$Env:Path

"`n== Path (Machine) =="
[Environment]::GetEnvironmentVariable("Path", "Machine")

"`n== Maven =="
& "mvn" "-B" "--version"

"`n== Java =="
& "cmd.exe" /c 'java -version 2>&1' # Output goes to STDERR which makes this invocation fail the build in PS

"`n== Building the artifact locally =="
& "mvn" "-B" "install" 2> $null