#!/usr/bin/env python3
'''A module with tools for request caching and tracking.
'''
import redis
import requests


redis_store = redis.Redis()
'''The local cache data storage.
'''


def get_page(url: str) -> str:
    '''Returns the content of a URL after caching the request's response,
    and tracking the request.
    '''
    req_key = 'count:{}'.format(url)
    res_key = 'result:{}'.format(url)
    redis_store.incr(req_key)
    result = redis_store.get(res_key)
    if result is None:
        result = requests.get(url).content.decode('utf-8')
        redis_store.setex(res_key, 10, result)
    return result
