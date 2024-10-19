async function payWrapper(payFunction) {
    payFunction() ? payBenefit() : null;
}

async function payBenefit() {
    fetch('/benefit-gateyway-pay', {
        name: 'ahmed',
        amount: 10,
        date: 'date'
    })
}