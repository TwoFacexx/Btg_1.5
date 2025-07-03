// Só coletar se o delay passou  
// Only collect if the delay has passed  
if (pode_coletar) {
    // MARCAR esta moeda como coletada PERMANENTEMENTE  
    // MARK this coin as permanently collected  
    marcar_moeda_coletada(moeda_id);
    
    // Log para debug  
    // Debug log  
    show_debug_message("Moeda " + moeda_id + " coletada permanentemente");
    
    // Coletar a moeda  
    // Collect the coin  
    global.moedas_total += valor;
    save_update_stat("moedas_total", valor);
    tocar_som(som_moeda, 6, false);
    
    // SALVAR automaticamente para persistir a coleta  
    // Automatically save to persist the collection  
    save_game();
    
    // Destruir a moeda  
    // Destroy the coin  
    instance_destroy();
}
