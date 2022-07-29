curl "https://containeranalysis.googleapis.com/v1/projects/binary-test-1/notes/?noteId=qa-note" \
  --request "POST" \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $(gcloud auth print-access-token)" \
  --header "X-Goog-User-Project: binary-test-1" \
  --data-binary @- <<EOF
    {
      "name": "projects/binary-test-1/notes/qa-note",
      "attestation": {
        "hint": {
          "human_readable_name": "QA note"
        }
      }
    }
EOF