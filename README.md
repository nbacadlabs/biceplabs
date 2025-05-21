# biceplabs

added more information
New test of

articlesection
----------------
artsecid
articleid
artsectiontext

codeblockarea
---------------
artsecid
codeblockid
codeblocktext


--article
 -articleid
   |--articlesection
       |-articlesecid
       |-articleid
       |-articlesecfulltext
          |-blockcodeid
          |-articlesecid
          |-blockcodefulltext
 
Articlesections and Blockcodes sections
-------------------------------------

class ArticleSection(models.Model):
    articlesecid = models.AutoField(primary_key=True)
    article = models.ForeignKey(Article, related_name='articlesections', on_delete=models.CASCADE)

class ArticleSecFullText(models.Model):
    blockcodeid = models.CharField(max_length=100)
    blockcodefulltext = models.TextField()
    articlesection = models.ForeignKey(ArticleSection, related_name='articlesecfulltexts', on_delete=models.CASCADE


Serializers
--------------------
class ArticleSecFullTextSerializer(serializers.ModelSerializer):
    class Meta:
        model = ArticleSecFullText
        fields = ['blockcodeid', 'blockcodefulltext']

class ArticleSectionSerializer(serializers.ModelSerializer):
    articlesecfulltexts = ArticleSecFullTextSerializer(many=True, read_only=True)

    class Meta:
        model = ArticleSection
        fields = ['articlesecid', 'articleid', 'articlesecfulltexts']

class ArticleSerializer(serializers.ModelSerializer):
    articlesections = ArticleSectionSerializer(many=True, read_only=True)

    class Meta:
        model = Article
        fields = ['articleid', 'articlesections']


Output Json
----------------
{
  "articleid": 1,
  "articlesections": [
    {
      "articlesecid": 101,
      "articleid": 1,
      "articlesecfulltexts": [
        {
          "blockcodeid": "B001",
          "blockcodefulltext": "Introduction to the topic."
        },
        {
          "blockcodeid": "B002",
          "blockcodefulltext": "Background and context."
        }
      ]
    },
    {
      "articlesecid": 102,
      "articleid": 1,
      "articlesecfulltexts": [
        {
          "blockcodeid": "B003",
          "blockcodefulltext": "Main argument and evidence."
        },
        {
          "blockcodeid": "B004",
          "blockcodefulltext": "Counterpoints and discussion."
        },
        {
          "blockcodeid": "B005",
          "blockcodefulltext": "Conclusion and summary."
        }
      ]
    }
  ]
}


CopyText example
-----------------

<template>
  <div>
    <h2>Block Codes</h2>
    <ul>
      <li v-for="(block, index) in blockcodes" :key="index">
        <span>{{ block.blockcodeid }} - {{ block.blockcodefulltext }}</span>
        <button @click="copyToClipboard(block.blockcodeid)">Copy</button>
      </li>
    </ul>
    <p v-if="copiedText">✅ Copied: {{ copiedText }}</p>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const blockcodes = ref([
  { blockcodeid: 'B001', blockcodefulltext: 'Introduction to the topic.' },
  { blockcodeid: 'B002', blockcodefulltext: 'Background and context.' },
  { blockcodeid: 'B003', blockcodefulltext: 'Main argument and evidence.' }
])

const copiedText = ref('')

const copyToClipboard = async (text) => {
  try {
    await navigator.clipboard.writeText(text)
    copiedText.value = text
    setTimeout(() => copiedText.value = '', 2000)
  } catch (err) {
    console.error('Failed to copy: ', err)
  }
}
</script>

<style scoped>
button {
  margin-left: 10px;
  padding: 4px 8px;
  cursor: pointer;
}
</style>
