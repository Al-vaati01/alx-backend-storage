#!/usr/bin/env python3
"""
Using Redis to cache
"""

import redis
import uuid
from typing import Union, Callable, Optional
import functools

"""
count_calls decorator that takes a single method
Callable argument and returns a Callable.
"""


def count_calls(method: Callable) -> Callable:
    """
    count_calls function
    """
    key = method.__qualname__

    @functools.wraps(method)
    def wrapper(self, *args, **kwargs):
        """
        wrapper function
        """
        self._redis.incr(key)
        return method(self, *args, **kwargs)

    return wrapper


"""
call_history decorator that takes a single method
"""


def call_history(method: Callable) -> Callable:
    """
    call_history function
    """
    key = method.__qualname__

    @functools.wraps(method)
    def wrapper(self, *args):
        """
        wrapper function
        """
        self._redis.rpush("{}:inputs".format(key), str(args))
        output = method(self, *args)
        self._redis.rpush("{}:outputs".format(key), output)
        return output

    return wrapper


"""
replay function that will display the history of calls of a function
"""


def replay(method: Callable):
    """
    replay function
    """
    r = redis.Redis()
    key = method.__qualname__
    count = r.get(key).decode("utf-8")
    inputs = r.lrange("{}:inputs".format(key), 0, -1)
    outputs = r.lrange("{}:outputs".format(key), 0, -1)
    print("{} was called {} times:".format(key, count))
    for i, o in zip(inputs, outputs):
        print("{}(*{}) -> {}".format(key, i.decode("utf-8"),
                                     o.decode("utf-8")))


class Cache:
    """
    Cache class to store data
    """

    def __init__(self):
        """
        Constructor
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    @count_calls
    @call_history
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        Store data in redis
        """
        key: str = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str,
            fn: Optional[Callable] = None
            ) -> Union[str, bytes, int, float]:
        """
        Get data from redis
        """
        data = self._redis.get(key)
        if fn:
            return fn(data)
        return data

    def get_str(self, key: str) -> str:
        """
        Convert data to string
        """
        return self.get(key, str)

    def get_int(self, key: str) -> int:
        """
        Convert data to int
        """
        return self.get(key, int)
