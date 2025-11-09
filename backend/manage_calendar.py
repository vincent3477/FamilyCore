from openai import OpenAI
from agents import Agent, Runner
import requests
import json
from json import loads


#{human_response: <string>, send_to_CM: <boolean>, CM_prompt: <string>}

"""
prompt1: add an event
agent: give more information

prompt2: more information
agent: ok adding information

"""



def gather_event_info(prompt):
    agent_id = "1c85260e-ac02-4487-9270-77c5202ea7dc"
    url = f"https://agents.toolhouse.ai/{agent_id}"

    payload = {"message": f"{prompt}"}
    headers = {}

    try:
        response = requests.post(url, json = payload, headers = headers)
        if response.status_code == 200:
            return response.text
        else:
            print(f"No response from agent. Code {response.status_code}")
            return None
    
    except Exception as e:
        print(f"Failed to qyery agent {str(e)}")
        return None
    

def main():
    prompt_log = {"Past messages": [], "Current prompt": None}
     
    while(True): 

        user_input = input("Do you want to add a new event?")
        
        prompt_log["Current prompt"] = user_input

        responses = gather_event_info(prompt_log)

        print(responses)

        qna = {"input": user_input, "model_response": responses}

        prompt_log["Past messages"].append(qna)

        json_response = loads(responses)

        human_response = json_response.get("human_response")
        send_to_CM = json_response.get("send_to_CM")
        CM_prompt = json_response.get("CM_prompt")

        if bool(send_to_CM):
            # call the calendar manager agent
            break
        print(str(human_response))
        
        


            
            


if __name__ == "__main__":
    main()







