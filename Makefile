.POSIX:
.SUFFIXES:

LIBS=-lvulkan
VARS=LD_LIBRARY_PATH=/usr/lib:${LD_LIBRARY_PATH} \
	HAREPATH=vendor/vk-v1.3:${HAREPATH}

demo:
	$(VARS) hare build $(LIBS) cmd/demo

run:
	@ # Bug https://todo.sr.ht/~sircmpwn/hare/569
	$(VARS) hare run $(LIBS) cmd/demo

.PHONY: demo run
