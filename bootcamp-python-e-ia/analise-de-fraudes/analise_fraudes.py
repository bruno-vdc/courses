# =========== bibliotecas ===========
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import shap
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, precision_recall_curve
from sklearn.ensemble import RandomForestClassifier
from xgboost import XGBClassifier

# =========== buscando e avaliando os dados ===========
url = 'https://storage.googleapis.com/download.tensorflow.org/data/creditcard.csv'

df = pd.read_csv(url)

print(df.head())

print(df.describe())

print(df.isna().sum().sum())

print(df['Class'].value_counts(normalize=True))

# =========== feature engineering ===========
df['Amount_log'] = np.log1p(df['Amount'])

scaler = StandardScaler()
df['Amount_scaled'] = scaler.fit_transform(df[['Amount']])

X = df.drop('Class', axis=1)
y = df["Class"]

X_train, X_test, y_train, y_test = train_test_split(X, y, stratify=y, test_size=0.3, random_state=42)

# =========== modelos e avaliações ===========
#logistic regression
model = LogisticRegression(max_iter=1000)

model.fit(X_train, y_train)

y_pred = model.predict(X_test)

print(classification_report(y_test, y_pred))

y_probs = model.predict_proba(X_test)[:,1]
precision, recall, _ = precision_recall_curve(y_test, y_probs)

plt.plot(recall, precision)
plt.title("Precision-Recall Curve")
plt.xlabel("Recall")
plt.ylabel("Precision")
plt.show()

#random forest
rf = RandomForestClassifier(n_estimators=50, max_depth=10, class_weight="balanced", n_jobs=-1, random_state=42)

rf.fit(X_train, y_train)

y_pred_rf = rf.predict(X_test)

print(classification_report(y_test, y_pred_rf))

y_probs_rf = rf.predict_proba(X_test)[:,1]
precision, recall, _ = precision_recall_curve(y_test, y_probs)

plt.plot(recall, precision)
plt.title("Precision-Recall Curve")
plt.xlabel("Recall")
plt.ylabel("Precision")
plt.show()

#xgboost
xgb = XGBClassifier(scale_pos_weight=10, use_label_encoder=False, eval_metric='logloss')

xgb.fit(X_train, y_train)

y_pred_xgb = xgb.predict(X_test)

print(classification_report(y_test, y_pred_xgb))

y_probs_xgb = xgb.predict_proba(X_test)[:,1]
precision, recall, _ = precision_recall_curve(y_test, y_probs_xgb)

plt.plot(recall, precision)
plt.title("Precision-Recall Curve")
plt.xlabel("Recall")
plt.ylabel("Precision")
plt.show()

# =========== importância das variáveis ===========
importancias = rf.feature_importances_

plt.bar(range(len(importancias)), importancias)
plt.title('Importância das variáveis')
plt.show()

importancias = xgb.feature_importances_

plt.bar(range(len(importancias)), importancias)
plt.title('Importância das variáveis')
plt.show()

explainer = shap.Explainer(xgb)
shap_values = explainer(X_test[:100])

shap.plots.bar(shap_values)