from google import genai
from google.genai import types
from google.adk.tools.tool_context import ToolContext
from google.cloud import aiplatform


async def generate_marketing_image(tool_context: ToolContext, prompt: str) -> dict:
    """
    Generate an image based on a text prompt using Gemini (Nano Banana).

    Args:
        tool_context: The ADK tool context for saving artifacts.
        prompt: The user prompt describing the image to generate.

    Returns:
        dict: Contains a message and artifact reference that the ADK Web UI will render inline.
    """
    # Use Vertex AI context already available in Agent Engine
    aiplatform.init()  # reads project & location automatically
    client = genai.Client(vertexai=True)

    # 1. Call Gemini image model
    response = client.models.generate_content(
        model="gemini-2.5-flash-image",
        contents=[prompt],
    )

    # 2. Extract the first inline image
    image_part = None
    for candidate in response.candidates:
        for part in candidate.content.parts:
            if part.inline_data:
                image_part = part.inline_data
                break
        if image_part:
            break

    if image_part is None:
        return {"message": "No image was generated."}

    # 3. Save it as an artifact for UI rendering
    artifact_version = await tool_context.save_artifact(
        filename="generated_image.png",
        artifact=types.Part(inline_data=image_part),
    )

    # 4. Return structured response (ADK Web UI will display the artifact inline)
    return {
        "message": f"Generated image for prompt: '{prompt}'",
        "artifact": {
            "filename": "generated_image.png",
            "version": artifact_version,
        },
    }