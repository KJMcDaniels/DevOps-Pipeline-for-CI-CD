import { Configuration, OpenAIApi } from "openai";
import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import dotenv from "dotenv";
import {
  SecretsManagerClient,
  GetSecretValueCommand,
} from "@aws-sdk/client-secrets-manager";

// Initialize dotenv to load environment variables
dotenv.config();

const app = express();
const port = 8000;
app.use(bodyParser.json());
app.use(cors());

const secret_name = "prof/EBEREGIT/app";
const region = "us-east-2";

const client = new SecretsManagerClient({
  region: region,
});

let apiKey;

const getSecret = async () => {
  try {
    const response = await client.send(
      new GetSecretValueCommand({
        SecretId: secret_name,
        VersionStage: "AWSCURRENT",
      })
    );
    const secret = JSON.parse(response.SecretString);
    apiKey = secret.API_KEY; // Assuming the secret contains a key named 'API_KEY'
    console.log("Successfully retrieved API key from Secrets Manager.");
    console.log(`Retrieved API Key: ${apiKey}`);
  } catch (error) {
    console.error("Error retrieving secret:", error);
    throw error;
  }
};

// Retrieve the secret and start the server
getSecret()
  .then(() => {
    const configuration = new Configuration({
      apiKey: apiKey,
    });
    const openai = new OpenAIApi(configuration);

    app.post("/", async (request, response) => {
      const { chats } = request.body;

      const result = await openai.createChatCompletion({
        model: "gpt-3.5-turbo",
        messages: [
          {
            role: "system",
            content: "You are Cyborg. A helpful bot that assits with cybersecurity. You are tasked with helping a user with a cybersecurity issue. The user is having trouble with a phishing email. They are asking for advice on how to identify phishing emails and what to do if they receive one. Please provide them with the necessary information to help them identify phishing emails and what to do if they receive one. The user can ask you many questions realted to cybersecurity both high level and in-depth. You assist with all their cyber needs and questions.",
          },
          ...chats,
        ],
      });

      response.json({
        output: result.data.choices[0].message,
      });
    });

    app.listen(port, () => {
      console.log(`Listening on port ${port}`);
    });
  })
  .catch((error) => {
    console.error("Failed to start server:", error);
    process.exit(1);
  });
