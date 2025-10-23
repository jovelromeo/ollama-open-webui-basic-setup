@echo off
echo 🚀 Starting Ollama + Open WebUI setup...

REM Start the services
echo 📦 Starting Docker services...
docker-compose up -d

REM Wait for Ollama to be ready
echo ⏳ Waiting for Ollama to be ready...
set timeout=120
set counter=0

:wait_loop
curl -s http://localhost:11434/api/tags >nul 2>&1
if %errorlevel% equ 0 goto ollama_ready

if %counter% geq %timeout% (
    echo ❌ Timeout waiting for Ollama to start
    exit /b 1
)

timeout /t 2 /nobreak >nul
set /a counter+=2
echo    Waiting... (%counter%s/%timeout%s)
goto wait_loop

:ollama_ready
echo ✅ Ollama is ready!

REM Pull a lightweight model suitable for most systems
echo 📥 Downloading Phi3 Mini model (this may take a few minutes)...
docker exec -it ollama ollama pull phi3:mini

echo 🎉 Setup complete!
echo.
echo 📋 Next steps:
echo    1. Open your browser and go to: http://localhost:3000
echo    2. Create an account in Open WebUI
echo    3. Start chatting with Llama3!
echo.
echo 🔧 Useful commands:
echo    • View logs: docker-compose logs -f
echo    • Stop services: docker-compose down
echo    • List models: docker exec -it ollama ollama list

pause