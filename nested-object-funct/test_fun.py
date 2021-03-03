from glom import glom

input_data={'x': {'y': {'z': 'a'}}}
input_key = "x.y.z"
output_value=glom(input_data, input_key )
print("Output value is", output_value)