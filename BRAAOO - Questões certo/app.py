from flask import Flask, render_template, request, jsonify
import mysql.connector

app = Flask(__name__)

# Configuração do banco de dados
db_config = {
    'user': 'root',  # Usuário MySQL
    'password': 'A0410j1306',  # Senha MySQL
    'host': 'localhost',
    'database': 'AOOB'  # Banco de dados
}

def get_db_connection():
    conn = mysql.connector.connect(**db_config)
    return conn

@app.route('/')
def index():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Pegando uma questão aleatória
    cursor.execute("""
        SELECT q.id_questao, q.textoPergunta, ac.textoAlternativa AS alternativa_correta_texto
        FROM Questao q
        JOIN Alternativa a ON q.id_questao = a.Questao_id_questao
        JOIN Alternativa_Correta ac ON ac.textoAlternativa = a.textoAlternativa
        WHERE a.Questao_id_questao = q.id_questao
        LIMIT 1
    """)
    question_data = cursor.fetchone()

    if question_data is None:
        return "Nenhuma pergunta encontrada.", 404

    question_id = question_data['id_questao']
    correct_answer_text = question_data['alternativa_correta_texto']

    # Pegando alternativas
    cursor.execute("""
        SELECT id_alternativa, textoAlternativa
        FROM Alternativa
        WHERE Questao_id_questao = %s
    """, (question_id,))
    alternatives = cursor.fetchall()

    if not alternatives:
        return "Nenhuma alternativa encontrada para esta pergunta.", 404

    conn.close()

    return render_template('index.html', question=question_data, alternatives=alternatives, correct_answer_text=correct_answer_text)

@app.route('/check_answer', methods=['POST'])
def check_answer():
    data = request.json
    user_answer = data.get('answer')
    correct_answer_text = data.get('correct_answer_text')

    print(f'User Answer: "{user_answer}"')  # Depuração
    print(f'Correct Answer: "{correct_answer_text}"')  # Depuração

    if user_answer == correct_answer_text:
        return jsonify({'result': 'Resposta correta!'}), 200
    else:
        return jsonify({'result': 'Resposta incorreta. Tente novamente.'}), 200

if __name__ == '__main__':
    app.run(debug=True)