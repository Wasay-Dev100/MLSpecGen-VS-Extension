/**
 * Embedder Script
 * Generates embeddings for all examples in kerasembedded_examples.json
 * and saves them back to the file
 */

import fs from 'fs';
import axios from 'axios';
import dotenv from 'dotenv';
import OpenAI from 'openai';

dotenv.config();

const EMBED_MODEL = "nomic-embed-text"; // Ollama model
const INPUT_FILE = "kerasembedded_examples.json";
const OUTPUT_FILE = "kerasembedded_examples.json"; // Overwrite same file

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

async function getEmbedding(text) {
  try {
    // Try Ollama first (default)
    console.log('Creating embedding with Ollama...');
    const resp = await axios.post("http://127.0.0.1:11434/api/embeddings", {
      model: EMBED_MODEL,
      input: text
    }, { timeout: 30000 });
    
    const body = resp.data;
    if (Array.isArray(body?.data) && body.data[0]?.embedding) {
      console.log('✓ Ollama embedding created, dimension:', body.data[0].embedding.length);
      return body.data[0].embedding;
    }
    if (Array.isArray(body?.embedding)) {
      console.log('✓ Ollama embedding created, dimension:', body.embedding.length);
      return body.embedding;
    }
    throw new Error("Unexpected embeddings response shape from Ollama.");
  } catch (error) {
    console.warn('Ollama embedding failed, trying OpenAI:', error.message);
    
    // Fallback to OpenAI
    try {
      const e = await openai.embeddings.create({ 
        model: "text-embedding-3-small", 
        input: text 
      });
      console.log('✓ OpenAI embedding created, dimension:', e.data[0].embedding.length);
      return e.data[0].embedding;
    } catch (openaiError) {
      throw new Error(`Both Ollama and OpenAI embeddings failed: ${openaiError.message}`);
    }
  }
}

async function generateEmbeddings() {
  console.log(`\n📖 Reading ${INPUT_FILE}...`);
  const data = JSON.parse(fs.readFileSync(INPUT_FILE, 'utf-8'));
  console.log(`Found ${data.length} examples\n`);

  let processed = 0;
  let skipped = 0;
  let errors = 0;

  for (let i = 0; i < data.length; i++) {
    const example = data[i];
    
    // Skip if embedding already exists and is not empty
    if (Array.isArray(example.embedding) && example.embedding.length > 0) {
      console.log(`[${i + 1}/${data.length}] Skipping ${example.postURL} - embedding already exists`);
      skipped++;
      continue;
    }

    // Create text to embed: question + answer
    const textToEmbed = [example.title, example.question, example.answer]
      .filter(Boolean)
      .join("\n\n");

    try {
      console.log(`[${i + 1}/${data.length}] Generating embedding for ${example.postURL}...`);
      const embedding = await getEmbedding(textToEmbed);
      
      // Update the example with the embedding
      example.embedding = embedding;
      processed++;
      
      console.log(`✓ Embedding generated (dimension: ${embedding.length})\n`);
      
      // Save progress every 10 examples
      if ((i + 1) % 10 === 0) {
        console.log('💾 Saving progress...');
        fs.writeFileSync(OUTPUT_FILE, JSON.stringify(data, null, 2), 'utf-8');
        console.log('✓ Progress saved\n');
      }
      
      // Small delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 500));
      
    } catch (error) {
      console.error(`✗ Error processing ${example.postURL}:`, error.message);
      errors++;
      
      // Continue with next example
      continue;
    }
  }

  // Final save
  console.log('\n💾 Saving final results...');
  fs.writeFileSync(OUTPUT_FILE, JSON.stringify(data, null, 2), 'utf-8');
  
  console.log('\n✅ Done!');
  console.log(`   Processed: ${processed}`);
  console.log(`   Skipped: ${skipped}`);
  console.log(`   Errors: ${errors}`);
  console.log(`   Total: ${data.length}`);
  console.log(`\n📁 Saved to: ${OUTPUT_FILE}\n`);
}

// Run the script
generateEmbeddings().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});
