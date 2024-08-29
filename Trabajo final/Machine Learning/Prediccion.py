import streamlit as st
import pandas as pd
from sklearn.ensemble import RandomForestRegressor
from sklearn.preprocessing import MinMaxScaler
import numpy as np

# Función para predecir el valor de mercado
def predict_market_value(input_data, model, scaler, feature_columns):
    # Normalizar los datos de entrada
    input_data_scaled = scaler.transform([input_data])
    # Hacer la predicción
    predicted_value = model.predict(input_data_scaled)
    return predicted_value[0]

# Cargar los datos y entrenar el modelo
df_completo = pd.read_csv("Tabla_total.csv")
X = df_completo.drop(columns = ['Player', 'Nat.', 'Club', 'Market value','overall', 'potential', 'total_gk', 'total_stats', 'cost', 'foot', 'position'])
print(X.columns, len(X.columns))
# X.shape ( 16 rows)
y = df_completo["Market value"]

# Normalizar los datos
scaler = MinMaxScaler().fit(X)
X_scaled = scaler.transform(X)

# Entrenar el modelo de Random Forest
model = RandomForestRegressor()
model.fit(X_scaled, y)

# Título de la aplicación
st.title("Estimación del Valor de Mercado de Jugadores Sub-21")

# Entrada de datos por parte del usuario
player_name = st.text_input("Nombre del Jugador")
age = st.number_input("Edad", min_value=15, max_value=21, value=18)
height_in_cm = st.number_input("Altura (cm)", min_value=150, max_value=210, value=180)
# foot = st.selectbox("Pie Dominante", options=["right", "left"])
# position = st.selectbox("Posición", options=["Midfield", "Forward", "Defender", "Goalkeeper"])
minutes_played = st.number_input("Minutos Jugados", min_value=0, max_value=50000, value=10000)
goals = st.number_input("Goles", min_value=0, max_value=100, value=10)
assists = st.number_input("Asistencias", min_value=0, max_value=100, value=10)
pace = st.number_input("Pace", min_value=0, max_value=100, value=70)
shooting = st.number_input("Shooting", min_value=0, max_value=100, value=70)
passing = st.number_input("Passing", min_value=0, max_value=100, value=70)
dribbling = st.number_input("Dribbling", min_value=0, max_value=100, value=70)
defending = st.number_input("Defending", min_value=0, max_value=100, value=70)
physical = st.number_input("Physical", min_value=0, max_value=100, value=70)

# Crear el array de características para la predicción
input_data = np.array([age, minutes_played, goals, assists, height_in_cm, pace, shooting,
                       passing, dribbling, defending, physical])

# Predecir el valor de mercado cuando se haga clic en el botón
if st.button("Estimar Valor de Mercado"):
    estimated_value = predict_market_value(input_data, model, scaler, X.columns)
    st.success(f"El valor estimado de mercado para {player_name} es: €{estimated_value:.2f} millones")

