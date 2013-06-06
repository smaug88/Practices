function muestra_figs (figuras)
    for contador = 1:length(figuras)
        set(figuras(contador), 'Visible', 'on');
    end
end