import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

st.title("Financial Health Assessment Tool")

uploaded_file = st.file_uploader("Upload Financial Data (CSV)")

if uploaded_file:
    df = pd.read_csv(uploaded_file)

    st.subheader("Uploaded Data Preview")
    st.write(df.head())

    total_revenue = df["revenue"].sum()
    total_expense = df["expense"].sum()
    total_loan = df["loan"].sum()
    total_tax = df["tax"].sum()

    profit = total_revenue - total_expense
    cash_flow = profit - total_loan - total_tax

    st.subheader("Financial Summary")
    st.write("Total Revenue:", total_revenue)
    st.write("Total Expense:", total_expense)
    st.write("Total Loan:", total_loan)
    st.write("Total Tax:", total_tax)
    st.write("Profit:", profit)
    st.write("Cash Flow:", cash_flow)

    if profit < 0:
        health = "Poor"
        insight = "The business is running at a loss and needs cost optimization."
    elif cash_flow < 0:
        health = "Warning"
        insight = "The business is profitable but cash flow is under pressure."
    else:
        health = "Good"
        insight = "The business is financially healthy with stable profit."

    st.subheader("Financial Health Status")
    st.success(health)
    st.info(insight)

    st.subheader("Revenue vs Expense vs Profit")
    labels = ["Revenue", "Expense", "Profit"]
    values = [total_revenue, total_expense, profit]

    fig, ax = plt.subplots()
    ax.bar(labels, values)
    st.pyplot(fig)
