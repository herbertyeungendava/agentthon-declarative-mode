# Goal
This project is an **interactive marketing assistant** built using **Google’s Agent Development Kit (ADK)** and **Gemini Enterprise**.

The goal is to provide a simple, hands-on way for students to:
- Generate creative marketing campaign ideas  
- Turn those ideas into detailed ad prompts for image generation  
- Produce campaign visuals using the Gemini (Nano Banana) image generation model  
- Experiment with refining prompts to improve visual outcomes  

This setup walks through creating, deploying, and connecting an ADK agent to Gemini Enterprise so students can interact with the full idea-to-image workflow.

---

# Setup

## Make a virtual environment and install libraries
```bash
python -m venv .venv
source .venv/bin/activate
pip install google-adk
```

## Log in to Google (requires gcloud)
```bash
gcloud auth login
gcloud config set project PROJECT_ID
```

## Initialize ADK project (if not already created)
```bash
adk create --type=config marketing_agent
```

## Build without code
Follow the official ADK documentation for YAML configuration:  
https://google.github.io/adk-docs/agents/config/

Test updating the prompts in each agents, adding your own agents and updating the steps.
Feel free to test adding your own new python tools if required as well.

Use the terminal command below to test your configuration locally:
```bash
adk web
```

---

# Deploy

Use the shell command in **deploy.sh** to deploy your agent to Agent Engine.  
- The deployment must use the **us-central1** region so it can connect with Gemini Enterprise.  
- Make sure to update the variable values in `deploy.sh` to match your environment and project.  

---

# Create a Gemini Enterprise App

1. Go to Gemini Enterprise and create a new app.  
2. Select **Global** as the location.  
3. Use the provided app URL to open and test your Gemini Enterprise app.  

---

# Connect Your Deployed ADK Agent to Gemini Enterprise

1. Get the **Gemini Enterprise App ID** from the *Apps* page in Gemini Enterprise.  
   - Replace `GEMINI_ENTERPRISE_APP` in `activate.sh` with this value.  

2. Go to **Vertex AI → Agent Engine** and locate your deployed ADK agent.  
   - Under *Resource Name*, copy the 18-digit ID at the end.  
   - Replace `AGENT_ENGINE_ID` in `activate.sh` with this number.  
   - Replace `AGENT_ENGINE_LOCATION` with `us-central1`.  

3. Update the **display name**, **description**, and **tool description** fields in `activate.sh` with suitable values.  

4. Run the shell command from `activate.sh` in your terminal.  

5. If the returned JSON includes `"state": "ENABLED"`, the registration was successful.  

---

# Test Your ADK Agent in Gemini Enterprise

1. Open your Gemini Enterprise app’s URL.  
2. Go to the **Agents** tab.  
3. Click your connected agent and start testing interactions.  

---

# Update Your Agent Using YAML

Follow the YAML documentation to extend your agent’s capabilities:  
https://google.github.io/adk-docs/agents/config/

Use the command below to test locally:
```bash
adk web
```

You can also add new Python tools or modify existing ones to introduce new functionality.

---

# Redeploy Your Updated Agent

After making changes, redeploy the updated version to Agent Engine using the **same deploy.sh command**.  
Keep the same display name and description—this will deploy a **new version** of your agent.

---

# Update Gemini Enterprise to the Latest ADK Agent

1. Get the **existing Agent ID** for the ADK–Gemini Enterprise connection:
   - Run the **FIRST** command in `update.sh` to list agents.
   - Replace `PROJECT_ID` with your project ID.
   - Replace `GEMINI_ENTERPRISE_APP` with your Gemini Enterprise App ID.
   - The response JSON will contain a `"name"` field under `"agents"`.  
     The ~19-digit number at the end of that string is your **`JSON_RESPONSE_ID`**.

2. In **Vertex AI → Agent Engine**, find your latest ADK deployment.
   - Copy the new reasoning engine ID and update the value of `NEW_AGENT_ENGINE_ID` in `update.sh`.

3. Edit the **SECOND** comand in `update.sh` to include:
   - `PROJECT_ID`
   - `GEMINI_ENTERPRISE_APP`
   - `JSON_RESPONSE_ID`
   - `NEW_AGENT_ENGINE_ID`
   - Updated display name, description, and tool description fields

4. Run `update.sh` in the terminal.  
   - If the response includes `"state": "ENABLED"`, your Gemini Enterprise agent is now connected to the latest ADK deployment.
