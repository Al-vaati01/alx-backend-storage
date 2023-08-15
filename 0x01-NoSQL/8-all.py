#!/usr/bin/env python3
"""
    8-all.py - List all documents in Python
"""


def list_all(mongo_collection):
    """ lists all documents in a collection  and returns empty list if no
        documents
    """
    docs = []
    for doc in mongo_collection.find():
        docs.append(doc)
    return docs
