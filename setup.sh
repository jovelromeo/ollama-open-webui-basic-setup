#!/bin/bash

echo "🚀 Starting Ollama + Open WebUI setup..."

# Start the services
echo "📦 Starting Docker services..."
docker-compose up -d

# Wait for Ollama to be ready
echo "⏳ Waiting for Ollama to be ready..."
timeout=120
counter=0
while ! curl -s http://localhost:11434/api/tags > /dev/null 2>&1; do
    if [ $counter -ge $timeout ]; then
        echo "❌ Timeout waiting for Ollama to start"
        exit 1
    fi
    sleep 2
    counter=$((counter + 2))
    echo "   Waiting... (${counter}s/${timeout}s)"
done

echo "✅ Ollama is ready!"

# Pull a lightweight model suitable for most systems
echo "📥 Downloading Phi3 Mini model (this may take a few minutes)..."
docker exec -it ollama ollama pull phi3:mini

echo "🎉 Setup complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Open your browser and go to: http://localhost:3000"
echo "   2. Create an account in Open WebUI"
echo "   3. Start chatting with Llama3!"
echo ""
echo "🔧 Useful commands:"
echo "   • View logs: docker-compose logs -f"
echo "   • Stop services: docker-compose down"
echo "   • List models: docker exec -it ollama ollama list"