#import <Flutter/Flutter.h>

@interface MylibPlugin : NSObject<FlutterPlugin>
@end
// NOTE: Append the lines below to ios/Classes/<your>Plugin.h

char *tx_decode(const char *cbor, bool testnet);

char *tx_encode(const char *json);

char *public_key_to_address(const char *pubkey, bool testnet);

void ffi_free(void *ptr);

void ffi_dummy(void);
