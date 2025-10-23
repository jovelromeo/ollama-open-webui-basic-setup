# Ollama + Open WebUI Docker Setup

This Docker Compose setup provides a complete interactive web chat interface for Ollama with Llama3 support.

## Services

- **Ollama**: The Ollama server running on port 11434
- **Open WebUI**: A modern web interface for Ollama running on port 3000

## Quick Start

1. **Start the services:**
   ```bash
   docker-compose up -d
   ```

2. **Wait for services to be ready** (this may take a few minutes on first run)

3. **Download a model:**
   ```bash
   # For systems with limited memory (< 6GB available)
   docker exec -it ollama ollama pull phi3:mini
   ```
   
   Or for other model variants:
   ```bash
   # For Phi3 Mini (recommended for limited memory systems - ~2GB RAM)
   docker exec -it ollama ollama pull phi3:mini
   
   # For Llama3 8B (requires ~6GB+ RAM)
   docker exec -it ollama ollama pull llama3:8b
   
   # For Llama3 70B (requires 40GB+ RAM)
   docker exec -it ollama ollama pull llama3:70b
   
   # For Gemma 2B (lightweight option - ~1.5GB RAM)
   docker exec -it ollama ollama pull gemma:2b
   ```

4. **Access the web interface:**
   Open your browser and go to: http://localhost:3000

5. **Create an account** in Open WebUI (first user becomes admin)

6. **Start chatting** with your Llama3 model!

## Available Models

You can pull and use various models:

```bash
# Lightweight models (good for limited memory)
docker exec -it ollama ollama pull phi3:mini
docker exec -it ollama ollama pull gemma:2b
docker exec -it ollama ollama pull qwen2:1.5b

# Medium models (require 6GB+ RAM)
docker exec -it ollama ollama pull llama3:8b
docker exec -it ollama ollama pull codellama:7b
docker exec -it ollama ollama pull mistral:7b

# Large models (require 16GB+ RAM)
docker exec -it ollama ollama pull llama3:70b
docker exec -it ollama ollama pull codellama:34b

# List available models
docker exec -it ollama ollama list
```

## Memory Requirements

Different models have different memory requirements:

| Model | Memory Required | Best For |
|-------|----------------|----------|
| `gemma:2b` | ~1.5GB | Very limited systems, basic chat |
| `phi3:mini` | ~2GB | Limited systems, good performance |
| `qwen2:1.5b` | ~1GB | Ultra-lightweight, basic tasks |
| `llama3:8b` | ~6GB | General use, high quality responses |
| `codellama:7b` | ~5GB | Code generation and assistance |
| `mistral:7b` | ~5GB | Balanced performance and quality |

**Recommendation**: If you have less than 6GB available system memory, start with `phi3:mini` or `gemma:2b`.

## GPU Support

If you have an NVIDIA GPU, uncomment the GPU configuration in the `docker-compose.yml` file under the ollama service to enable GPU acceleration.

## Useful Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# View Ollama logs specifically
docker-compose logs -f ollama

# View Open WebUI logs specifically
docker-compose logs -f open-webui

# Restart services
docker-compose restart

# Update services
docker-compose pull
docker-compose up -d
```

## Configuration

- **Ollama API**: Accessible at http://localhost:11434
- **Open WebUI**: Accessible at http://localhost:3000
- **Data Persistence**: Both services use Docker volumes for data persistence

## Troubleshooting

1. **Services not starting**: Check if ports 3000 and 11434 are available
2. **Model not found**: Make sure you've pulled the model using `ollama pull`
3. **"Model requires more system memory" error**: 
   - Try a smaller model like `phi3:mini` or `gemma:2b`
   - Close other applications to free up memory
   - Check available memory with `docker stats`
4. **Slow performance**: Consider enabling GPU support if available
5. **Connection issues**: Ensure both services are running with `docker-compose ps`

## Security Note

Remember to change the `WEBUI_SECRET_KEY` in the docker-compose.yml file to a secure random string before deploying to production.