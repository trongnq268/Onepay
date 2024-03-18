# custom_library.py
def extract_token_value(string, start_marker, end_marker):
    start_index = string.find(start_marker)
    if start_index == -1:
        return f"Không tìm thấy chuỗi '{start_marker}' trong URL."

    start_index += len(start_marker)

    end_index = string.find(end_marker, start_index)
    if end_index == -1:
        return f"Không tìm thấy ký tự '{end_marker}' sau chuỗi '{start_marker}' trong URL."

    return string[start_index:end_index]
