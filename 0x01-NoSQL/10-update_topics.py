#!/usr/bin/env python3
""""
This script updates the topics of a school document based on the name
"""


def update_topics(mongo_collection, name, topics):
    """
    Function that changes all topics of a school document based on the name
    """
    mongo_collection.update_many({"name": name}, {"$set": {"topics": topics}})
