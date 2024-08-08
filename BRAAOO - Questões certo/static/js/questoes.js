let selectedOption = null;
const correctAnswerText = '{{ correct_answer_text }}'.trim(); // Recebe do template HTML
let lives = 3; // Número inicial de vidas

function selectOption(option) {
    if (selectedOption) return; // Já selecionou uma opção

    selectedOption = option;
    const selectedButton = document.querySelector(`button[onclick="selectOption('${option}')"]`);

    // Destaca o botão selecionado
    selectedButton.classList.add('selected-option');
    submitAnswer();
}

async function submitAnswer() {
    const result = document.getElementById('result');

    try {
        const response = await fetch('/check_answer', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ answer: selectedOption.trim() })
        });
        const data = await response.json();

        result.textContent = data.result;

        //Não está funcionando
        // Atualiza os botões com base na resposta
        document.querySelectorAll('.option').forEach(btn => {
            if (btn.textContent.trim() === selectedOption) {
                btn.classList.add(data.result.includes('correta') ? 'correct' : 'incorrect');
            } else if (btn.textContent.trim() === correctAnswerText) {
                btn.classList.add('correct');
            }
        });

        if (!data.result.includes('correta'));
    } catch (error) {
        result.textContent = 'Ocorreu um erro. Tente novamente.';
    }
}


