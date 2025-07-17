.PHONY: deploy
deploy:
	./deploy.sh

.PHONY: destroy
destroy:
	sudo containerlab destroy -t ipclos.clab.yaml
	kind delete cluster
