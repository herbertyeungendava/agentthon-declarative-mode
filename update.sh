# GET THE AGENT ID
curl -X GET \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "X-Goog-User-Project: PROJECT_ID" \
  "https://discoveryengine.googleapis.com/v1alpha/projects/PROJECT_ID/locations/global/collections/default_collection/engines/GEMINI_ENTERPRISE_APP/assistants/default_assistant/agents"

# UPDATE THE AGENT WITH THE NEW ADK AGENT
curl -X PATCH \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  -H "X-Goog-User-Project: PROJECT_ID" \
  "https://discoveryengine.googleapis.com/v1alpha/projects/PROJECT_ID/locations/global/collections/default_collection/engines/GEMINI_ENTERPRISE_APP/assistants/default_assistant/agents/JSON_RESPONSE_ID" \
  -d '{
    "displayName": "DISPLAY_NAME",
    "description": "DESCRIPTION",
    "adk_agent_definition": {
      "tool_settings": {
        "tool_description": "TOOL_DESCRIPTION"
      },
      "provisioned_reasoning_engine": {
        "reasoning_engine": "projects/PROJECT_ID/locations/us-central1/reasoningEngines/NEW_AGENT_ENGINE_ID"
      }
    }
  }'



  curl -X DELETE \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  -H "X-Goog-User-Project: p-dev-gcp-syd-agentthon-s2gw-1" \
  "https://discoveryengine.googleapis.com/v1alpha/projects/p-dev-gcp-syd-agentthon-s2gw-1/locations/global/collections/default_collection/engines/GEMINI_ENTERPRISE_APP/assistants/default_assistant/agents/JSON_RESPONSE_ID" \
  -d '{
    "displayName": "DISPLAY_NAME",
    "description": "DESCRIPTION",
    "adk_agent_definition": {
      "tool_settings": {
        "tool_description": "TOOL_DESCRIPTION"
      },
      "provisioned_reasoning_engine": {
        "reasoning_engine": "projects/p-dev-gcp-syd-agentthon-s2gw-1/locations/us-central1/reasoningEngines/6304041121760673792"
      }
    }
  }'