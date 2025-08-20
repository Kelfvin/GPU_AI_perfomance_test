import time
from openai import OpenAI
import pandas as pd

client = OpenAI(base_url="http://localhost:8000/v1", api_key="dummy")

prompt = "你好，请用中文写一个故事，500字左右！"

# 记录开始时间
start = time.time()

resp = client.completions.create(
    model="Qwen/Qwen3-8B",
    prompt=prompt,
    max_tokens=512
)

end = time.time()

print(resp)
if resp.usage:
    generated_tokens = resp.usage.completion_tokens
    time_used = end - start

    print(f"Generated {generated_tokens} tokens in {time_used:.2f} seconds")
    print(f"Throughput: {generated_tokens / time_used:.2f} tokens/s")

else:
    print("Usage information not available")
