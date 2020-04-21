
async function quickstart(
  projectId = 'YOUR_PROJECT_ID' // Your GCP Project Id
) {
  // Imports the Google Cloud client library
  const {Translate} = require('@google-cloud/translate');

  // Instantiates a client
  const translate = new Translate({projectId});

  // The text to translate
  const text = 'Hello, world!';

  // The target language
  const target = 'es';

  // Translates some text into Russian
  const [translation] = await translate.translate(text, target);
  console.log(`Text: ${text}`);
  console.log(`Spanish: ${translation}`);
  
    const target1 = 'fr';

  // Translates some text into Russian
  const [translation2] = await translate.translate(text, target1);
  console.log(`French: ${translation2}`);
  
    const target2 = 'de';

  // Translates some text into Russian
  const [translation3] = await translate.translate(text, target2);
  console.log(`German : ${translation3}`);
}
quickstart('c03f688392266c79d44f1f9ce86936d944ba664a')