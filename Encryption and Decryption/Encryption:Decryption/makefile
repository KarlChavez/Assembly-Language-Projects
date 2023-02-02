#Karl Chavez

all: decode encode

decode: decode.o
	gcc decode.o -g -o $@

encode: encode.o
	gcc encode.o -g -o $@

encr: 
	encode < in1testEncode.test > out1testEncode.test
	encode < in2testEncode.test > out2testEncode.test
	encode < in3testEncode.test > out3testEncode.test
	encode < in4testEncode.test > out4testEncode.test
	encode < in5testEncode.test > out5testEncode.test
		
decr: 
	decode < in1testDecode.test > out1testDecode.test
	decode < in2testDecode.test > out2testDecode.test
	decode < in3testDecode.test > out3testDecode.test
	decode < in4testDecode.test > out4testDecode.test
	decode < in5testDecode.test > out5testDecode.test
	
%.o: %.s
	gcc -g -c $< -o $@

zip:
	zip lab5.zip makefile *.s readme *.test

clean:
	rm -rf *.o
