const express = require('express');
const {Configuration, OpenAIApi} = require('openai');
const prompt = require('./prompt');
const app = express();
const port = 3000;

const apiKey = process.env.OPEN_AI_API_KEY; // Replace this with your OpenAI API key
const configuration = new Configuration({
    apiKey: apiKey,
});
const openai = new OpenAIApi(configuration);
let lastText = "";
// Middleware to parse JSON bodies
app.use(express.json());

app.get('/', (req, res) => {

    res.send("Hello World");

})

function similar(a,b) {
    var equivalency = 0;
    var minLength = (a.length > b.length) ? b.length : a.length;
    var maxLength = (a.length < b.length) ? b.length : a.length;
    for(var i = 0; i < minLength; i++) {
        if(a[i] == b[i]) {
            equivalency++;
        }
    }


    var weight = equivalency / maxLength;
    return (weight * 100);
}


app.post('/api/periodically',async (req, res) => {
    const inputText = req.body.text;


    let percent = similar(inputText, lastText);


    console.log(percent)

    if (percent < 5) {

        console.log("Different Meeting Text")
        if (!inputText) res.status(400).send('Text is missing in the request body.');

        const response = await openai.createChatCompletion({
            model: 'gpt-3.5-turbo',
            messages: [{
                role: 'user',
                content: inputText
            }]
        });

        console.log(response.data.choices[0].message.content);

        res.json({"todos": response.data.choices[0].message.content});
        lastText = inputText;
    } else {
        res.json({
            "todos": []
        })
    }


})


// Demo API endpoint
app.post('/api/demo', (req, res) => {

    // Your demo API logic here
    console.log("Demo Called! You got this! Enjoy your work",req.body)

    res.json({
        "result": {
            "language": "Türkçe",
            "meet_suggested_title": "Türk Hava Yolları Toplantısı",
            "meet_pure_text": "' Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayTürk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay ' Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayTürk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay' ' Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayTürk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay' ' Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayTürk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler' Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayTürk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay'' Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay Türk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayTürk hava yolları ile ilgili yapacağımız toplantının detaylarını konuşacağız bazı yapmamız gereken işler var eda hanım sizler maliyet tablosunu Türk hava yolları toplantı için hazır olmanız gerekiyor bunu iki gün içerisinde bana Elif'e Mehmet bey sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay teşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolayteşekkürler iyi günler kolay sizlerde bu Türk hava yolları sında yapacağımız sunum hazırlamanı istiyorum bir hafta süreniz var toplantımız bu kadar herkese teşekkürler iyi günler kolay' kolay''",
            "meet_content_summarize": "Türk hava yolları toplantısının detayları ve yapılması gereken işler konuşulacak.",
            "recognize_person_names": ["Eda Hanım", "Elif", "Mehmet Bey"],
            "todos": [{
                "todo_title": "Maliyet tablosunu hazırla",
                "todo_content": "Maliyet tablosunu Türk hava yolları toplantısı için hazırlanmalı.",
                "deadline": "2 gün",
                "tags": ["ekonomi"],
                "deadline_time": "",
                "created_time": ""
            }, {
                "todo_title": "Sunum hazırla",
                "todo_content": "Türk hava yolları toplantısı için sunum hazırlanmalı.",
                "deadline": "1 hafta",
                "tags": ["sunum","hazirlik"],
                "deadline_time": "",
                "created_time": ""
            }]
        }
    });
});

// e4e32370-3097-11ee-bcfb-45fbda29633d
// Release API endpoint
app.post('/api/release', async (req, res) => {
    try {
        const inputText = req.body.text;

        if (!inputText)  res.status(400).send('Text is missing in the request body.');

        const response = await openai.createChatCompletion({
            model: 'gpt-3.5-turbo',
            messages: [{
                role: 'user',
                content: inputText
            }]
        });

        console.log(response.data.choices[0].message.content);

        res.json({"result": response.data.choices[0].message.content});

    } catch (err) {
        console.log('Error: ' + err);
        res.status(500).json({error: 'Server Error'});
    }
});

app.listen(process.env.PORT, '0.0.0.0',()=>console.log("3000 Portundan Ayağa Kalktı"));


