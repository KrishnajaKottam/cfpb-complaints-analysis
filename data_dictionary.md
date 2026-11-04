| Column | What it means | Quality notes |
|---|---|---|
| Date received | Day the CFPB got the complaint | Stored as text like `2023-12-31T13:46:40.000Z`; convert to a date. Range 12/31/2023 to 11/04/2026 |
| Product | Main type of financial product | 11 values. About 89% are "Credit reporting or other personal consumer reports" |
| Sub-product | More specific product type | 55 values, no missing |
| Issue | Main problem the consumer had | 81 values, no missing |
| Sub-issue | More specific version of the problem | 189 values, about 2% missing |
| Company public response | Short public reply the company chose to share | About 44% missing; most filled values say the company chose not to give a public response |
| Company | Company complained about | 788 companies. Three credit bureaus make up about 87% of complaints |
| State | State of the consumer | Only one value (AR), so it is not useful for analysis |
| ZIP code | Consumer ZIP code | 458 values. Some are partly hidden (e.g. `720XX`) for privacy; keep as text |
| Tags | Special labels (Servicemember, Older American) | About 97% empty, which means "no tag" |
| Submitted via | How the complaint was sent | 4 values. 99% are Web |
| Date sent to company | Day the CFPB forwarded it to the company | Text date like Date received |
| Company response to consumer | How the company answered | 5 values; includes "In progress" (4,550 complaints, still open) |
| Timely response? | Whether the company replied on time | Yes 99,287, No 422 (a very small share) |
| Complaint ID | Unique complaint number | Unique for every row, no duplicates |