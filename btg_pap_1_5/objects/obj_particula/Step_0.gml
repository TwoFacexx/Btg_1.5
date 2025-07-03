// Rotacionar  
// Rotate  
image_angle += rot_speed;  
// pt-PT: Atualiza o ângulo da imagem adicionando a velocidade de rotação  
// EN: Updates the image angle by adding the rotation speed  

// Aplicar movimento  
// Apply movement  
velv += grav;  
x += velh;  
y += velv;  
// pt-PT: Atualiza a velocidade vertical com a gravidade e move a entidade  
// EN: Updates vertical velocity with gravity and moves the entity  

// Diminuir alpha baseado na vida  
// Decrease alpha based on lifetime  
vida_atual--;  
image_alpha = vida_atual / vida_maxima;  
// pt-PT: Reduz o valor da vida atual e ajusta a opacidade proporcionalmente  
// EN: Decreases current lifetime and adjusts opacity proportionally  

// Destruir quando invisível ou sem vida  
// Destroy when invisible or out of life  
if (image_alpha <= 0 || vida_atual <= 0) {
    instance_destroy();
}
