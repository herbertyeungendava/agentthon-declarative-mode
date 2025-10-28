curl -X POST \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  -H "X-Goog-User-Project: PROJECT_ID" \
  "https://discoveryengine.googleapis.com/v1alpha/projects/PROJECT_ID/locations/global/collections/default_collection/engines/GEMINI_ENTERPRISE_APP/assistants/default_assistant/agents" \
  -d '{
    "displayName": "DISPLAY_NAME",
    "description": "DESCRIPTION",
    "adk_agent_definition": {
      "tool_settings": {
        "tool_description": "TOOL_DESCRIPTION"
      },
      "provisioned_reasoning_engine": {
        "reasoning_engine": "projects/PROJECT_ID/locations/AGENT_ENGINE_LOCATION/reasoningEngines/AGENT_ENGINE_ID"
      },
    }
  }'
