// Contador de delay  
// Delay counter  
if (delay_coleta > 0) {
    delay_coleta--;  // pt-PT: Decrementa o delay a cada frame  
                     // EN: Decreases the delay each frame
} else {
    pode_coletar = true;  // pt-PT: Permite que a moeda seja coletada quando o delay termina  
                          // EN: Allows the coin to be collected when the delay ends
}
