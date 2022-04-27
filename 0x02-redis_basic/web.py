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
    if redis_store.exists(req_key) == 0:
        redis_store.set(req_key, 1)
    else:
        redis_store.incr(req_key, 1)
    if redis_store.exists(res_key) != 0:
        result = redis_store.get(res_key)
        return result.decode('utf-8') if result else result
    result = requests.get(url).content.decode('utf-8')
    redis_store.set(res_key, result)
    redis_store.expire(res_key, 10)
    return result
