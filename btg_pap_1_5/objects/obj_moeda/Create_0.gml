valor = 10;  
// pt-PT: Define o valor da moeda  
// EN: Sets the coin's value

image_speed = 1;  
// pt-PT: Define a velocidade da animação da imagem  
// EN: Sets the image animation speed

// CRIAR ID ÚNICO para cada moeda baseado na posição  
// CREATE UNIQUE ID for each coin based on position  
moeda_id = string(room) + "_" + string(x) + "_" + string(y);

// VERIFICAR se esta moeda já foi coletada  
// CHECK if this coin has already been collected  
if (moeda_ja_coletada(moeda_id)) {
	
    // pt-PT: Se já foi coletada, destruir imediatamente  
    // EN: If already collected, destroy immediately  
    instance_destroy();
    exit;
}

// Delay para evitar coleta instantânea  
// Delay to prevent instant collection  
delay_coleta = 30;

// Indica se a moeda pode ser coletada (inicialmente falso)  
// Indicates if the coin can be collected (initially false)  
pode_coletar = false;
