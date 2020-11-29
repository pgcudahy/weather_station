def postData(data_dict, url="http://192.168.1.151:9494/station"):
    try:
        response = urequests.post(url,
            headers = {'Connection': 'Close', 'content-type': 'application/json'},
            json = data_dict)
    except Exception as e:
        print("Error sending packet: {}".format(e))
        return False
    return response
