use std::ffi::{CStr, CString};

use libc::{c_char, c_void};

use forest_address::{Address, Network};

use filecoin_signer::api::{MessageTxAPI};
use filecoin_signer::*;

#[no_mangle]
pub extern "C" fn tx_decode(cbor: *const c_char, testnet: bool) -> *mut c_char {
    let cbor = unsafe {
        assert!(!cbor.is_null());

        CStr::from_ptr(cbor)
    };
    let cbor = cbor.to_str().unwrap();

    let cbor_data = CborBuffer(hex::decode(&cbor).unwrap());

    let parsed = transaction_parse(&cbor_data, testnet).unwrap();
    let result = match parsed {
        MessageTxAPI::UnsignedMessageAPI(tx) => serde_json::to_string(&tx),
        MessageTxAPI::SignedMessageAPI(tx) => serde_json::to_string(&tx),
    };

    let result = result.unwrap().to_string();

    let result = CString::new(result).unwrap();
    result.into_raw()
}

#[no_mangle]
pub extern "C" fn tx_encode(json: *const c_char,
) -> *mut c_char {
    let json = unsafe {
        assert!(!json.is_null());

        CStr::from_ptr(json)
    };
    let json = json.to_str().unwrap();

    let tx = serde_json::from_str::<MessageTxAPI>(json).unwrap();
    let tx = tx.get_message();

    let result = transaction_serialize(&tx).unwrap();

    let result = hex::encode(&result);

    let result = CString::new(result).unwrap();
    result.into_raw()
}

#[no_mangle]
pub extern "C" fn tx_digest(cbor: *const c_char) -> *mut c_char {
    let cbor = unsafe {
        assert!(!cbor.is_null());

        CStr::from_ptr(cbor)
    };
    let cbor = cbor.to_str().unwrap();
    let bytes: &[u8] = &hex::decode(&cbor).unwrap();

    let result = utils::get_digest(bytes).unwrap();
    let result = hex::encode(&result);

    let result = CString::new(result).unwrap();
    result.into_raw()
}

#[no_mangle]
pub extern "C" fn public_key_to_address(pubkey: *const c_char, testnet: bool) -> *mut c_char {
    let pubkey = unsafe {
        assert!(!pubkey.is_null());

        CStr::from_ptr(pubkey)
    };
    let pubkey = pubkey.to_str().unwrap();
    let pubkey: &[u8] = &hex::decode(&pubkey).unwrap();
    let mut address = Address::new_secp256k1(pubkey).unwrap();

    if testnet {
        address.set_network(Network::Testnet);
    } else {
        address.set_network(Network::Mainnet);
    }

    let result = address.to_string();

    let result = CString::new(result).unwrap();
    result.into_raw()
}

#[no_mangle]
pub extern "C" fn ffi_free(ptr: *mut c_void) {
    if ptr.is_null() {
        return;
    }

    unsafe {
        Box::from_raw(ptr);
    }
}

#[no_mangle]
pub extern "C" fn ffi_dummy() {
    println!("load fil codec");
}


#[cfg(test)]
mod tests {
    use crate::{tx_decode, tx_encode, tx_digest, public_key_to_address};
    use libc::c_char;
    use std::ffi::{CStr, CString};

    #[test]
    fn test_decode_and_encode() {
        let cbor = CString::new("8a005501fd1d0f4dfcd7e99afcb99a8326b7dc459d32c62855011eaf1c8a4bbfeeb0870b1745b1f57503470b71160144000186a01961a84200014200010040").unwrap();
        let cbor: *const c_char = cbor.as_ptr() as *const c_char;

        let tx: *mut c_char = tx_decode(cbor, false);
        let tx = unsafe { CStr::from_ptr(tx) };
        let tx = tx.to_str().unwrap();

        println!("decode: {}", tx);

        let data: *const c_char = tx.as_ptr() as *const c_char;
        let data = tx_encode(data);
        let data = unsafe { CStr::from_ptr(data) };
        let data = data.to_str().unwrap();
        // println!("encode: {}", data);

        assert_eq!(data, "8a005501fd1d0f4dfcd7e99afcb99a8326b7dc459d32c62855011eaf1c8a4bbfeeb0870b1745b1f57503470b71160144000186a01961a84200014200010040");
    }

    #[test]
    fn test_public_key_to_address() {
        let pubkey = CString::new("048bfab3a70675389cf61836a09d2dd7a61163905d88c0d507ed18a1b94e7119f3e36646cd711337f373b91814fe7258a58e2206273620f71254928389930abd70").unwrap();
        let pubkey: *const c_char = pubkey.as_ptr() as *const c_char;

        let address: *mut c_char = public_key_to_address(pubkey, false);
        let address = unsafe { CStr::from_ptr(address) };
        let address = address.to_str().unwrap();

        // println!("address: {}", address);

        assert_eq!(address, "f1j5klxt6zktifpibt7jlafmdxkfe4fwjhm6yqjhq");
    }

    #[test]
    fn test_digest_message() {
        let cbor = CString::new("885501fd1d0f4dfcd7e99afcb99a8326b7dc459d32c6285501b882619d46558f3d9e316d11b48dcf211327025a0144000186a0430009c4430061a80040").unwrap();
        let cbor: *const c_char = cbor.as_ptr() as *const c_char;

        let message_digest: *mut c_char = tx_digest(cbor);
        let message_digest = unsafe { CStr::from_ptr(message_digest) };
        let message_digest = message_digest.to_str().unwrap();

        assert_eq!(
            message_digest,
            "5a51287d2e5401b75014da0f050c8db96fe0bacdad75fce964520ca063b697e1"
        );
    }
}
