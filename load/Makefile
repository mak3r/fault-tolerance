IMAGE=network-load
REPOSITORY=mak3r
build :
	docker build -t $(REPOSITORY)/$(IMAGE):local .

TAG="latest"
publish : build
	docker tag $(REPOSITORY)/$(IMAGE):local $(REPOSITORY)/$(IMAGE):$(TAG)
	docker push $(REPOSITORY)/$(IMAGE):$(TAG)

test : build
	docker run --rm --name $(IMAGE) $(REPOSITORY)/$(IMAGE):local

#interactive test	
testint : build
	docker run -it --rm --name $(IMAGE) --entrypoint /bin/bash $(REPOSITORY)/$(IMAGE):local