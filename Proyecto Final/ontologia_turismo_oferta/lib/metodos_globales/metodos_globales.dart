String obtenerTextoDespuesDePenultimaComa(String input) {
  List<String> partes = input.split(',');

  if (partes.length >= 2) {
    // Une los elementos desde el penúltimo hasta el último
    String resultado = partes.sublist(partes.length - 2).join(',');
    // Elimina los espacios en blanco al inicio y al final si es necesario
    return resultado.trim();
  } else {
    return "La cadena no contiene suficientes comas.";
  }
}
