#!/usr/bin/env python3
'''A module with tools for request caching and tracking.
'''
import redis
import requests
from functools import wraps
from typing import Any, Callable


redis_store = redis.Redis()
'''The module-level Redis instance.
'''


def data_cacher(method: Callable) -> Callable:
    '''Caches the output of fetched data.
    '''
    @wraps(method)
    def invoker(url) -> str:
        '''The wrapper function for caching the output.
        '''
        res_key = f'result:{url}'
        req_key = f'count:{url}'
        redis_store.incr(req_key)
        result = redis_store.get(res_key)
        if result is not None:
            return result.decode('utf-8')
        result = method(url)
        redis_store.setex(res_key, 10, result)
        return result
    return invoker


@data_cacher
def get_page(url: str) -> str:
    '''Returns the content of a URL after caching the request's response,
    and tracking the request.
    '''
    if url is None or len(url.strip()) == 0:
        return ''
    return requests.get(url).text
