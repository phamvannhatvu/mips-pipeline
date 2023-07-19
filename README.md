# A simple implementation of MIPS pipeline architecture on FPGA
* Source code is contained in [Pipeline.src/sources_1](https://github.com/phamvannhatvu/mips-pipeline/tree/main/Pipeline.srcs/sources_1) folder
* Documentation (as a report for an assignment of Computer Architecture course at HCMUT) can be found [here](https://github.com/phamvannhatvu/mips-pipeline/blob/main/Documentation.pdf)
* Architecture diagram is stored [here](https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=PipelineForever.drawio#R7V1Zd5tIFv41PmfmQT7sy6Mdy51k4o7H7hwneemDJWJrIhk1womTXz8gAxL3FltRVRQSeeiWMBSI%2Bu6%2BnehvVi9%2FhN768SqY%2B8sTTZm%2FnOgXJ5qmu4YS%2Fy858is9olnpkYdwMX89pu4O3C5%2B%2B%2BnB7LTnxdzfFE6MgmAZLdbFg7Pg6cmfRYVjXhgGP4unfQuWxbuuvQcfHbideUt89G4xjx5fjzqmsjv%2B1l88PGZ3VpX0LysvOzk9sHn05sHPvUP69ER%2FEwZB9Ppp9fLGXyZvL3svr9ddlvw1f7DQf4qaXPAf7evs3v%2B5ev%2FRC6dfgu%2F%2Fvbh6nGi6%2FbrOD2%2F5nP7k9HGjX9k7eAiD5zW%2BXfHNe%2FfZ6env%2FeGHkf%2Byd2r6WH%2F4wcqPwl%2FxKelfnfSKFCMTK0PNz90b14zsxT7uv24zu5uX7vNDvvruVcQf0rdBfjNf%2Fnz2zj58%2FvHpn%2FcPt5a7%2Fvr4%2FXriWujFvIv%2Fo9z%2BdfbHFL2i%2BA09zf1kPeVEP%2F%2F5uIj827U3S%2F76M6aM%2BNhjtIrvf6HGH%2Bfe5nF7bvLl22K5fBMsg3C7kD49uzQv38THN1EYfPf3%2FmLNHP%2F%2BW%2FyXVfAjfdnJ9aG%2FWfze%2Fx5EXrT3PaZIf%2F%2B7P1%2Fsf10Gs%2B%2F5cxe3MvlzsomLmBrOlouHp%2FhYFCS%2FZRP%2FtMXTQ3JOctm34ClKKVdX8kfPyCU5gsFTg8bG2NEdjBXDEQwVB0Fl%2BnkqBCuXU5eEFUe71y1LMFZqUFECJYFYcSyMFUswVlRFRWC5O%2BePlUt7ak0tElbuHdMwFcFYaQiOIqJEYkVTNAwWXThYFASWq%2BmVALRcXp6R0TK37i1TNGeRHi2qSVBZhIshE2ssl0I4y%2FnlJQkrrmXrnmiskLEBEbT07v3ldbBZRIsgOWsWQ8IP9y7%2FAE5YLebz5B7nXrpufkUfsBPDk3799evOXs5%2FebfPN7P38%2FCvf96uJm69veA%2Fzc8S0yt5S0tvs1nMimgqQg%2FBRlEuLxXRAqntJvnzgt1YuUUmYYeyY6G%2F9KLFj6K1Sdq09A7XwSJ%2BwJzx2MB20i2w75vgOZz56VX71iFYyDFqFoq88MGP0EJbDOU%2Fmx5WKpZ0GFfxO79NvwZh9Bg8BE%2Fecro7CpC1O%2BdDkHCB7Ub%2Fz4%2BiXykr8J6joAhNOcAYYzD89Tn98%2FbLl%2BTLqZl9vXjZ%2F%2BPFL0pO87qnVbuiN0R7RxjnToMMfQoljFWruJAN%2BWAJjGN%2B5f3aO22dnLApf2B4n%2ByBGz%2BXUTg%2F%2FvD6BGxpSkM0dR2vpNz4D4tNIrwggdVoAVC05jIxd20p%2B7oClobJIo9BuPgdS2NvmZ4iM5en9mFZJLcESVBzk9MZ6e5rg1vbod2et9naw9hJTanfSqLOxW8rDbSVMQnHBxL1%2FvLdRTfd%2FkAJUgcc1yBZaIRttKDiw24bsX3WUXWGDPk%2BiKJgRVZjEkUGUa0u%2BXZLomVD7m7r7qll0WkoEJektXjr2ji0cTP9Y9ONjcgMo%2BZcw5KP%2BeMA3dl8TlDejnC3oNlgEBz8JB5vcNssHAnqyOLlNkht8RapXJJBLeMXbcWCW1zHhAYwK7sVPK%2FhirBDsc%2FQ6EgWiT%2BXRBTl5FJqvEJX8NL%2FFlE5gmXmqbXkkuJjkjiZ9gGiYo7Kk5yAomXYlOSEJANcqISedgtlJwbfvm18LmqYhiPBJ5rlrRJRvYy2m1z8phCEyXK5WG%2F8YxH4JvQT6j0L%2FEy%2BsxP4%2Fssi%2Bpy99vjznuc3%2FrYTs8mXTMoibpj8k0Z5aAuHVxofjg6Qr5PpALQxGOSygMoEZ7tQwy7D0dQoMQx1QnqIWM6DnYLjZpVtVkNvPL%2FNwh6XUdS3FPVu33tIsO3NczWWzGfKiXnRVexThnyL%2FlyNLPRT3y9BTdgelxkwtQ6BjLSaWjjKqaNlSlovNo4BmJMNEdtUXbB0oHe47Gyctn4FwyD%2FqLJnh%2BcbqgA%2FhEbIXTLPNUYUXEZd5fTIjuaHTcFqawo2dPUQKBjKuKZePxkpWDcFUHDG8faTGlarGL9e5DMg3zQtTFWpyHlYZNmc2oxDIDULeBadhvmNMpJa9ux8SQ17J29wiJi3iDwMCurTpc6OguBCAxZWtiKCgjRMQdFIQXQyyDQOk4ga5idLSUSaCCLCPuk09zH%2BeLkts%2B3i7zzQ5EdUzdHQW23DiAMz75mO3dWXz0%2BzkR%2FS8UPFtZxD4IcQqO6A%2BaErhB%2FiJOLbR2810hEdHanaQagViIzgQkMiIxGlUTopINeJgnBiPaKdJPdCIVBbfnznED7Vcifwl4xkKjzCMhNjrf830%2BwlSeeAKroJwyqNdX2rZiHO6RxNWjsNMRmZuTQQgyuHVam2BnClNcRVW0buwiwKq5qRw%2FM1EbnFOo7KJ27K9DtLll4aWyex9Px4adrxmD7MgXXDOi3aMnKoT7H0dTJDPo5mJ%2B5F%2BZE%2FAp090KHZTA10hvY3K6Bnj8hVjxmAVVubF21oUik8MD8JGaW0IFUVwc1pDEIs1H%2B42DD2uuR2YLnlSJsyJDOu6w3EprjeJQg5tiWSH9tqEaEWreJhI6j36MmBzaUsEVHTbLP3aE3Js6Of7jfrLcKyLpp7pLd59NbJxyiM%2F%2F87SG5yvvbDRfxAiX69O369O1gXHvq2ePGzptTJ9036sVK%2F2VLTa7GgKzvtNQ8p2RZEpolVHlJMiVtlvIFDg%2Bz1gtS%2FQVOVJfO%2B1%2BoSWXmJLLoEqLEyWDFYtBBvVQLHQUfQMgNt03Z1gkALo%2FC0CjAELVqIN2hx0HEYMjlviHSYMhm6AcyGNVL8RDIOqykd2VtzB%2Bpe9MxuFT1rH6iTGT7s4m1lvq6JYGcXrK9WKdkoDMihhWRwdnEK2nULTMuMd0mEPTMXAPR2oYV4C3tCRG1ML6JLL9KdzI4adn6RbSvgZ5jsWKfoBKP84fn6sXB47uN6FszZhOYOpby7OSlZbmbdDZuUYM1nU%2FYumkoqnb0iNaJsA%2Ffl0XyUR8dbyomFEcPmbuKFkS1AGJmkVnPsxZCC7Q2NTG2jVdHQqgAmKypbpk70aOhCbEsPjkJ%2B4NLnKuEKfMlBYORoBHlryYCGV1EPMWrYQK8ryLMHbgry7Ln4glxgpGkEeWuQo%2BaOtOnfekMvZmvNBrbQdWo0G9iwTURLJ5P5TA2Kqp00zLoLrX452YusEsOsw%2BoVU5952DKkEJvzWVNwQXoU7JVGnT8Ae7T22EcGPouQ%2FCyTU%2BXcKFb6FSsoMYaTgdBVrBgiDAQLR%2BFu5h1hfqw%2BJ9VUD7PGesAdxFwRHcQscmneSEQ0RGRbh0lEDS10KYlIhBVvkav8RiKiICLtEClIVQbchy9%2FeK40lIWHxujHwIwb2DKBup57V0bVsqCbGQTHANyBQJA2NoEh2LDUmhkEtRGChwFBWtUBQ7Czj4c5SEVEZkeQ8hiEyoxRqnBCtmhGKSJwOmJQBAZN%2BjntGIaCm07YOLT5JsZGGCwRGndoS3avpn5urxQu2X0vnKXFdJohOczoh4eZhMHgpDHu3Nof2zhqdvbh04lmbee93Yfxp4fo9SWNO9xkhxF5ugR%2FjtgtZl65dax%2BOquwsWL9dFDZRg2pqeWHmNbWzKUQYerhiOrBo5rahESoFtKfiDmqCZMAR1QPHtW0yfEY1UJi%2B6xRnb2OEdUHhWrajC6MaiHBduao5h86SdINixNZ1RO9TXtFmhRgmSmlNuE3s2drm424crVkUrW6OZCNqQutJDik6GiILi6D8KcXzrFb4flpgZNGRp9CnU9BVQlzs4Q6FRzsiz778ClYM%2BGAlf29a8seDrKBvXLqaqbQygQo7qkrE2KsAnHPay5EdaeA2vPzMGTjXwKvOOmtGYHDqd6optX%2BWA%2FRlJy02hg3dbTcaejAa0tPGgpb1dAHuiDXRUpJsOsF2W%2FnmqfncB7KNRJXV%2B3ZhDFRnRlxcSo3UtHEXb1G%2BMALVK2mhcEuA5f6CqdKvjEjL%2F7zwHJDelj1rbKQF7Y%2F6IVXXeMQVvQFb5Q%2FM18s47BUbBdtwhlTgaGOhtHOMLKtrDepFG5RejsJaYicuoR0tZPsqvoioUYPjpa9dmPWlNmjP%2FuOaG70LNV5lvJyoBrHEuT%2FzBxLmW%2BgONIoPvD23d8fPlbsqFK%2Fo49BuPgdM0dvmZ4%2FX4Txm37dY9%2FbRIezr7CsK%2BdSNR3YVWhLsttYjbuWl5tMY%2FYqS%2B1PY%2Ba5gKhsmnrUWvnTNfIjlz4ZvMAV4VdwcVHBNvkSUIWIYRVwDgVilTITSht5V1Zvt0dLOQ8UEklx%2BXeKouCLRxc4zvQOWZiuAdr208eDYaMau2GLdHGZFKqClb7bVz3ef4li8FeofaMi%2F2rDQb%2B40bMeryoi9L2xWkmEvkedao6aS3TW99izHpzIcHdeVs80JjMwG1KuuEYBGkN12qEewZImN2TP1bvTTtWw1%2B6t95uYHjaPjZlX%2F8yoANRZNvnkm3TDtYYaADfDRtWZFzMQLZvhp3f3JNfpi2102Decmx8HOoxExPBUwrRI9sBtrbrS5oDLTBq1adpZiEdWGqLXjWGadtOGzd19oTVDAdAFBmNf6M3vd28nl59vo%2FO%2Fv9x9en%2F24%2FzN5USEtThGB4YVHeA0gYxBdIBxd0AiRWAhNH2Z%2BWuiOjwmk7DqZ6v12c6WYc49nDjDSUPrapbqdRmJ6IdUdYjmZMcSyTNDhgiJtZsgXlT9tIPW%2FbIRtZJIOmYTDUw40YATbTIelIN%2Fh9Px%2FCqXFDMyFdHg9LjJVK5KWnZkClPjNPfUBk3bjoVSdRGUSjABU3odPb%2BVOS1liK%2FJ9eMX%2B9VxUI01091rjTC%2FXCyzq2TeUkkYJPYD06eWAORZnEb%2BxYAiP3K5xQ7tEhFD%2F1ysa9yFMX%2Fihn1syBPM9eHHR%2FbCxoVNFWucc6Sbpm2d6vMihFrAzLl8mQJtN%2B1zo57sJSvmqYsHmK6oNe1zI5kRbYIotQElRmPt3K1ZiF2XGzL4maftjuBvDH61KfjlMk0h%2BHWYidsY%2FNA%2Ba5jSywz8uGL7PPSeZo9MNJ0xMEGqcnXVA6lyhXlKkibMaT0kzJGJDZeUv39erUdS40VqzmHSmS0pndmy0BlOV7zyVze%2BN2dKamMe%2BL5UczSZWtqyozadkyesc7y9yg8mktqyCAbnHMvhO7%2F6oYRd%2B5zOHX64pZ7ABj9KjVMYXlAXZUO%2FxKhqfMKMMDREGD1MJ8fq4aCJaNdF1VZUkRKG2XjlXctfWN%2FBtWl6ya%2FqOl65jvLgj1WFUB72Z8cKILcITqW%2Bd2B96na2lZvRXy8KH%2ByhiKr1mks5Rx5ytCzyryp7eHi%2BVqNE4h8rIv9Zwx72G%2F%2FhYhP1TIyHIwwdLSvSHzoxQkAfNDFWX8CJGHE1wk1XQhy10lwrtVxbJOUx1EoVeSiPv1YK%2BykL0UoFdkcuC0EfdP6yYTYkV1HDoqGDnDZKbAMjyoSZ0IwcMTbkAaYIsmA%2B%2F7OcLGSGtzSoheEmWtRqUL3ps10ZEXrZbAG52gMMGqS7%2BstYvS3KWKEmiYp0COpBEnDUO1ppEDmeOk5pZmiEj%2BkHJGPAzByRQwuCovFYqJu0JFHQgUz6IlOkxlr6jMN0xQsafsN0dwd6MMFdjfyzSgkTxnnUqvJ%2BZiSE%2B26PJDR4EtoNr2JAQ0ImUpfQBBI9ddINiV0RfimdEJ6Z%2FhEfmH6exgteTa8QTXUb1iEzxbSo1oV2QV5mXlOta7Io1yXvJPN2d8fKDh1Dlyl5uEMSF0QpXooLR2SuLGPn%2BZW%2Fkqe98yHAPinL1Q6kmzOEvcVp%2BmdXA9bqwRr98uezd%2Fbh849P%2F7x%2FuLXc9dfH79cT7B66IEn%2BGlm%2FefTmW7JLkDv3No8VfiKZSaaFGgCDJhahaQepXTOTAV3ErWTuVzh6r3Zfw48199QCjYoac0CIS3Zua1YsR2RzmVqgHkaMcCfJDS0bdt5XUw1qR1htUguzZjQW%2BZHLm9FAAu1BepMb1mBSYlbvNpKTdP1qmJEWWkm2WCZRcJjM3b7lBt%2BB5e%2F3FH03XffUpsQsMuUadhNnhjb%2BakreeHTEVoMEpRJ7qy2woDA3OcW44QNn92Hl1CeDlnlXoxGa9dBU1ZjNFcuiqLvWkhbrXoHLnDmKmLAzMsemCIQOVJ0afTB7k9tkKHQjxjFPMmxxOGFvJgecXvfoPc2XfoiAPXYwhs5QTS9upsjZdeSN5p9dno%2Buy0dtnzRv34fNi13pxq5a40u2zwMt3agf2p1adPs1HuT9lG2MGDRO6Bku1GuZtZJlxjRxX6WzD5%2B2tORFz7i1xcgeUYP3kj4kIoZ7E7c0ex6h7DFniTlbK2WPZcxQOWRmmI1KHB4zVIvwtukT0MFKVueed6yZoSVmHE2BctSTLorFUGhiEFBHkSDq8iI4PpSfoQVuZIpoN4CpRKq0rQOtPNJVt%2Bg4GmoaF1KYJO3GaPTQjZE8sUfBFBcr6cF6JDZexBbD3T1MYuucMcSJ2KqGmImMQ1saSbrxSrwo6WB1yBnJPeddwHw8lETcPBmvzk3ESslDN5Ilv9jCORvxk1neKvEDPd1v1lsYZdJrj3I2j946%2BRiF8f9%2FB8lNztd%2BuIgfKBEiu%2BPXu4N1zqZvixd%2FnvqXtmnL6ccE3Yk7ZzHzlmeptFot5vPkWfY9VK7sBNbCJwXlR27J1JQxcUtftkSkhTpj%2FrKA%2FGXTPXX3%2F9FyT5gQKp1r3MLpFtw7zh6bKmBZFhicI7S7BkttAK7ETRsoeeQabSBLey2Wgk2g7c1RWeDfKm8sYeFCJHaZNtGaSBy3ZqX%2BmT7OLYiZftJWSSDPp%2B30OERZURsQy4yMNm3Ms%2B7UPUmRJDPatLvrSBYh49px%2BIgV2KfCqookCDUycYbCayuLbSnr5d05Isyxk8W27zTAjshOFsSNtJlHV8dOFnL40OhbWSCYyt%2FKgoxt7DUesX3k2EYlfqraUN3l0bhKtcqaxpSrH6j%2FW1WQhhkpYadyrH2PbheWROaqrlbY2knfURj6rDJEZJ1bUjfUxutCnOiC%2FNF616ltUmn5SGNMaczWMk4mhyCjJjGkozUt1pWrwNzGVW0XMZCSDWGG%2B5pcmrTmDeH%2BEGrh9jpk2702iXdhwjKtSx9OwOoeoSp74uoOJPUXqHrdMB3Ye7DtBbYli%2BQieINGycWYgi3tMCQXomBeMbm22W%2FoAjXLEC%2B7woR%2BkrYX2FUluEIpmHkXgzEOODDJijTK7t3AWKM04xSjQ2%2FgDj0NTmxj6tBrWMLGw6GHetDUOvTwFdnzc3XoOfyr6o5XVevZkYeoi6UjD04cZqStaXB%2BfZ22hi7IH613ZcrREG2dzecxmjeM%2FBrHKrXcXn0Y7IJQyATqcQSw6paNQCi3k5DjouYKA7lGWl5Q2f6VGdniGNf0Ol5KufEfFpuosi0RTU7LfBHGhPNa5%2BB7m0hyMm1R6QCbn%2BYlDDVpLvw6tTvMSx1oWgXQphAOs1NbfauBptmGTtNsQ1HtN8DkXoNav9IBpegN46TMeB5%2Fv08eSTkSv8%2FOxlYzRbAffUUBYtqhLqNAg3l5BV1ghMOpC7pIGxJx%2BLfrPDbCGmvrABExT%2BoW0WJ2DAKIwCy7YiBuiVslU3PKE7eUlrLBMTpeYFdlhrEiOmyYXH36jMhu83OxWnpPPsmOrJsUFu9YlJbgG1vSS9e6XCyXGcHN%2FW%2Fe87YZ77Damc2C5dJbb%2Fx5gXI6mKo2QUkjmapVBRnp3W6Sn%2Fb0EP%2B2drcjDzGD0sJbRn745EX%2BecJxucgDDReHKoPoJHEfRFGwysC510mC4HIpkBMZgpV02xxqcAZSM6DxG17Hv2FzPpuI1vHRbi9q%2FQiabGIbhjxohTYnGY0aXvEXhxpOJStlLy9BA77BjZxBA3aTwMhFknP2OHsv7u27k8R5Xd0k6yl41SpoiHqeqBAnpWXO27Pavf8Wg8LU%2BF9hB8S6V2AVML0HsHKdQWRx6ziZ4MPHEXuisAfzXWixx6z1s1DsaQh7r73yY0MlsWj6d2BwQ6HuGH0GxKF5DdxkBiUo7eKynfNNegElDiUnwvhyyxV5AbO5Nzg980iAqSp8kKl2bpHcCzRxxG%2F6eXoU%2FDIW2r1WsQPXajKpU9mDpUYHS9htXoXB6GHAEsceRj9oj35QkzAwh6UfFIB2QmiEQ%2FaDQl%2BHAD%2BoPvpBGxAutSNUbehy5%2BY6MbD5utPWaqsYJTFis30YrBWL%2BrDQmrFNG7rIJQANHAiUqIaWEwgTDCqGRDrZdhQwD6WM2TxhoZgkNlvm2ndTMAAnpG7HfXJB6upNp3qdDhUFrNBkYgUp2abb9GsQRo%2FBQ%2FDkLae7owA3u3M%2BBME6hdb%2F%2FCj6lWpE3nMUFIG3N9jQbjXmtVxut8RibR60kVqltfHLxmlHjTHZTW9qEEGOwsWr7s8qUEehb0L9gFCNIDRUZ%2FTQLqOMr%2B6Rh9aKPFpuFztsS%2BtmhO5Aav21oV9RKO%2FG0WUJIMslmYQnYk3V7FPbhXFDoOuCJtbUYcTqZUXWNsJyArYJLMS5gCZ2Fo2OTHGOTBtgXCcIe2LpIZ0j0wGVMRPS%2FXSSdsE5oZOMTaywDcORWToaDMOrmiibK41gYwVma5J%2FAdYZ%2F%2FRfEl6XlCizlcB5gLgscFy6PS23Y7i%2BStG6Xm9%2BIeL%2BWVgbPA%2B9p9njiETRSITpMbRAbJhmIxRlOCzz%2FjkWVdJgjKHtXAnOfUuE%2FKa01ig2NVciS4RV6Ef2yE%2Fl7o1aWS1wNdguoWetjDBrtyN7ytqK7FqJfNn7C7mtCB%2BW1s5b3nLL933ilaYKO94nai4fI%2FnsUMnnrh6SLHms6WMxrpAl7zCOjDPRNsv8i%2BUeyZw61JOOnsdu8j4jDiqtVRAdQIuJurgNLtQwki5UguM4OQNNdbj4pNBHLdUVCU9NYwRPLUkYMYtr9Ru%2FIe8ITq994y1nz%2FFLjPEmlxPJSw%2BEr7vOy5SPNRzb6TN%2BqAHjxVBOdcrSBF2DS%2FWJwNXllyBafZ1dRc%2FR5ffr7x%2F%2Ffrif8O83PPaWEdJGzIYCuLEkzxljpjx2TopreKPskVmpqUSAYyt%2BBPgwAU6tqqJibm4AhyF3xq0ZiAJWVcYanV5rdFBb94Y1OqhmpmGRDoyBGvh2WSPnYk0QVD8EhLZVZahFOl29qDuypA5u506rvvyoMQ%2FGuxffTEn2S0mkuaKOO3eC7VbCxpGq5jhuHM5LGDeORHJAySCFLsTuXKYj76d0Rvn3bqpr6QvHErvtKx9spB6NJaLOGWE434iZ%2BFWxff9utYoVKq9zhvAIJgKYWOV9NJ3nIxZM2Ja%2B2RwUa8rd3TKAibZ3GRyD0LB3mVgo4Qg9w%2FZQLcBU5gYvd5wfC%2Fxo5SKEn5RiEceu7xIzdL4dci4Ke%2B2DM8eCPVoxCrEnpRTFUekesCcV35Mr65Fe8Ko1C0kBP%2BwtHiWvbAikTbxFCGyYeSsWgdglLA51h4sh2LZcTQo%2BwSrUOGKYO9M5F7JYLlp7fvbsfINw6ugpb9rRrrA7%2BWS9%2FhyuhLYPh%2BVwlashg05dVWLXLCSDcMtwOqpXEiOQeioARKCMCr6GXf7Hbl9KBj%2FqiBOEn4yutUyZLzLATTjriL0OafedG9JUA7E27z5PgmmeA22ZptYjRFE1B3VZSMNpmlwMh5IfxdcQ0HBk4zIIf3rhXGFPAdu%2Bdw3me%2FEpPGlDAS1Lo5TTmGULpQANtD9G2XKNbWeYxcUw65%2FL0NkSHOMQSYrjrt6aIeNYHUCJH2w5Sj1fHPZAldLewtGUFKaEtqbtSr4pQdce3hzYrdta4XBtodwW5jCz4rZy6sQ45pL2aOw74pwPq0eo5WyVKaeGXGNfdNryEt2qWUgKBOKYy8e1H3pP85O8ecfAvZw9ZwJqwDiHxR20cGo4RFYsmnCwY4emrnJXAjQpp5qu9AomkA6q6W7ML5XdP8qesBBcPVckh%2FeGFUU%2Frpy1%2FZ%2Fru4%2Fvb6%2BX%2BoTgQe%2BIqHKfo8x1abLUYRpAw0KhuMaqGgR1Q%2FC19%2FtAC7zo%2BKl9MNaOIjLM%2BVfe7%2Bxniu5VMpNG7eiGxk0nBNEQmjtD3dfEFERDUJ3JnAFNHwyc35mGPv74PvHe%2F724%2B3x1%2FZ%2BL9%2F7szZ8rQm3%2Flb9i1%2F1%2BfwJT%2B374Wb%2BUWQzqbeKGSIraaxjXsV9cNSXWuiIcra3qZdnZLFQxxOkA2rTgoM7G%2FjLYBnF3gDF1urDivKY9HDw%2FL1lvfEEmIlv8dr2CAXDSJ5%2F%2B%2B%2BkyWF9%2F979Gd3%2F9fnNzZ4bXE%2Bx7uf1y%2B%2Fd69nd8pCObEEnRLIoFOiqc%2FfhpALCoDWvoKezZsiZilXlmrEiEsnB8D8MkgpCk1uYgJBu6DlnBDbtxEta4DLw5hl386j949%2F6yiDak5JSnmALspTIuXtw8PzEvMFY5WxhV9Fe8%2FiTfpuZprhPl1IADDDUm4NOKTvMJ8AQx4U1fH16%2B%2FnfjG9O7Z8N89%2FQuVuTeETrF%2Fek%2FbCkyfmHL7%2FF%2F%2F6X%2B%2B0Szti2A7sP400Py6cbfPg88PH2Z%2BettyvFwGBxzdrUDi6OJVXohC9tN%2Fm6t9YKVHNnn3BPBjS1JIgfkPBTzQB2VjGPFegcDrbCQzct5AiOCSoUpxMqfiNnz2AROXBM4pMkRmrKRWnfRtYDTAc%2BdGArpdoT7oRuy7QFHRiaGpjKIFnD3QRQFqwybr%2BVRk5L6qEqabA4jOBkRd9%2Fm1QCO%2FAOwXOy7P3W7V98lf2AitPW5AfUol07I6Wr1OhJEeAnNX%2FobmncseMpzArsCCi0kA6JwsvJb77cXEvwYjEKqZc4udqnKVTDcD7tUytwWeFUM2xIJUM11T23aPBYlpq%2FieId%2Bs%2B7Im4Bzk0fFp0TxgdyKUBYuVvPBYaPpIUkn1KxiIromEmw4dbsxudpwkreHeVxHIiQptlXsHCYYSZoL9RNWSGJY3d3WhQSr0eoGwKHzGU%2BAI2MFx49YufWHq3iZrQnIMBxdKMGo9IpXkqCjFMm958lv5F3APV24MdwsuVI92UutzBMtycmVx8ekoRFpuqcWpUEKG11J1ZzKqubTvJtTEaPaGiKG0QwhUwqMEJFynXiZIcStw54yZslrEqmQFshp6NcUoR97DhlTvwXTREBhR1l5ys%2FBaWxV3LENXBXXEQlQVadX2PavlcNCJm4C9pSN3I0VeKBIizUvjQ5MsE0tYSmxWLK%2FPLwL%2FlloQWS%2FfXsx%2B72aPkTsR5rKnLggSUqsDvVg6nwytBLy51AnlDEDmIIQdh1siqmQWiEVcg971j%2FPwfZwEM79cDJ75URn2%2BXCf00m%2B8f%2FvQVEdkVpRiXT1Ss8OIeWAlzFPZikAFuGBvoOsmHphTV5JAAT3ww2I0e%2BypuvOqZ76oBOBNSslbSYhNwV4wxxV33krsPkrhpL7uroXAosRPFT7NsZ%2BSl3a8iEla30hQ9oKQl5KXb3IF5qjLx0mLxUZ8lLLdCMzWBCbgZpTf6cFaN%2B5Ky8OaumoL631JXaaCkJOSv2WCLOao6cdZic1WDJWV29Iy%2FN%2FMbCFFPmzviRfdayT4uZXgpXYleQy4x3Yg99De98ZUuo3py%2Fk%2FUo2Z%2FJkP05CkgzZmOkZ8tkyf%2BiWCPOCh9ZI3ebHfVzpLfZ0VKKfNwR%2B4VE2uyIyfL3tR4lk7UYMllbBfOtMt9AVy6rFzUJUVx20G2whsplbR2kCdFzWbiUhCooFuQizXfEZPk7YY%2BSybLs5%2BVoSpEddgzm82ejuDxnZKPc3aC6c2oXK5M7OELxYvKxUlxqU9MXbuRujLibw5K7WTow1NlEgIAKmUckBaSBjlpkH7Z6VnqXxfzoTXXVOXUcd%2FevsK7euXcbc7xhcTva0oJyNlnqeZzSigAf1BkY0%2FHXMEhAsDs99NaPV8E82e%2Fp%2FwE%3D)
