def main():
    print("it works!")


def application(environ, start_response):
    start_response('200', [])
    return ["it works!"]
