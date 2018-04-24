struct nodo_lista {
	int valor;
	struct nodo_lista * prox;
};

struct nodoLista * agregar_valor (struct nodo_lista * anterior, int a) {
	if (anterior == NULL) {
		struct nodo_lista * aux = malloc(sizeof(struct nodo_lista));
		aux -> valor = a;
		aux -> prox = NULL;
		return aux;
	}
	return agregar_valor (anterior -> prox, a);
}

void eliminar_lista (struct nodo_lista * nodo) {
	if (nodo == NULL) {
		return
	}
	if (nodo -> prox != NULL) {
		eliminar_lista (nodo -> prox);
	}
	free (nodo);
	return;
}
